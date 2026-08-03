import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../proformas/models/proforma_document.dart';
import '../../proformas/widgets/proforma_save_status.dart';
import '../../proformas/widgets/proforma_table_builder.dart';
import '../../settings/models/measure_unit.dart';
import '../../settings/providers/settings_providers.dart';
import '../providers/template_providers.dart';

class TemplateEditorScreen extends ConsumerStatefulWidget {
  const TemplateEditorScreen({super.key, required this.templateId});

  static const routePath = '/plantillas';

  final int templateId;

  @override
  ConsumerState<TemplateEditorScreen> createState() =>
      _TemplateEditorScreenState();
}

class _TemplateEditorScreenState extends ConsumerState<TemplateEditorScreen> {
  static const _debounce = Duration(milliseconds: 450);
  static const _documentMountDelay = Duration(seconds: 2);

  final _nameController = TextEditingController();

  ProformaDocument _document = ProformaDocument.empty();
  bool _hydrated = false;
  bool _dirty = false;
  ProformaSaveStatus _saveStatus = ProformaSaveStatus.idle;
  Timer? _debounceTimer;
  int _saveToken = 0;

  bool _documentUiReady = false;
  bool _documentMountScheduled = false;
  Timer? _documentMountTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _documentMountTimer?.cancel();
    if (_dirty) {
      unawaited(_persist(immediate: true));
    }
    _nameController.dispose();
    super.dispose();
  }

  void _hydrateFrom(Template? template) {
    if (template == null || _hydrated) return;
    _nameController.text = template.name;
    _document = ProformaDocument.fromJsonString(template.documentJson);
    _hydrated = true;
    _scheduleDocumentMount();
  }

  void _scheduleDocumentMount() {
    if (_documentMountScheduled || _documentUiReady) return;
    _documentMountScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _documentMountTimer?.cancel();
      _documentMountTimer = Timer(_documentMountDelay, () {
        if (!mounted) return;
        setState(() => _documentUiReady = true);
      });
    });
  }

  void _scheduleSave() {
    if (!_hydrated) return;
    _dirty = true;
    setState(() => _saveStatus = ProformaSaveStatus.pending);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, () => _persist());
  }

  void _onDocumentChanged(ProformaDocument document) {
    setState(() => _document = document);
    _scheduleSave();
  }

  Future<void> _persist({bool immediate = false}) async {
    if (!_hydrated) return;
    if (!immediate) {
      _debounceTimer?.cancel();
    }

    final token = ++_saveToken;
    setState(() => _saveStatus = ProformaSaveStatus.saving);

    try {
      await ref.read(templateServiceProvider).saveEditorState(
            id: widget.templateId,
            name: _nameController.text,
            document: _document,
          );
      if (!mounted || token != _saveToken) return;
      _dirty = false;
      setState(() => _saveStatus = ProformaSaveStatus.saved);
      ref.invalidate(templatesListProvider);
      ref.invalidate(templateByIdProvider(widget.templateId));
    } catch (_) {
      if (!mounted || token != _saveToken) return;
      setState(() => _saveStatus = ProformaSaveStatus.error);
    }
  }

  Future<void> _onBack() async {
    _debounceTimer?.cancel();
    if (_dirty) {
      await _persist(immediate: true);
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(templateByIdProvider(widget.templateId));
    final prefs = ref.watch(userPreferencesProvider).valueOrNull;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final defaultUnit = prefs?.unit ?? MeasureUnit.m2;

    ref.listen(templateByIdProvider(widget.templateId), (previous, next) {
      final value = next.valueOrNull;
      if (!_hydrated && value != null) {
        _hydrateFrom(value);
        setState(() {});
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text('Plantilla'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _onBack,
        ),
        actions: [
          if (_saveStatus != ProformaSaveStatus.idle)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  _saveStatus.label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: _saveStatus == ProformaSaveStatus.error
                        ? colorScheme.error
                        : colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: async.when(
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AppLoadingPanel(message: 'Cargando plantilla…'),
          ),
        ),
        error: (error, stackTrace) =>
            const Center(child: Text('No se pudo cargar la plantilla')),
        data: (template) {
          if (template == null) {
            return const Center(child: Text('Plantilla no encontrada'));
          }
          _hydrateFrom(template);

          final bottomInset = MediaQuery.paddingOf(context).bottom;
          return ListView(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottomInset),
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Nombre de la plantilla',
                hint: 'Ej. Obra estándar',
                textInputAction: TextInputAction.done,
                onChanged: (_) => _scheduleSave(),
              ),
              const SizedBox(height: 10),
              Text(
                'Solo el cuerpo del documento. Cliente, proyecto y teléfono '
                'se completan al crear la proforma.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: 22),
              if (_documentUiReady)
                ProformaTableBuilder(
                  document: _document,
                  defaultUnit: defaultUnit,
                  textImageFolder: 'templates',
                  onChanged: _onDocumentChanged,
                )
              else
                const AppLoadingPanel(message: 'Cargando documento…'),
            ],
          );
        },
      ),
    );
  }
}
