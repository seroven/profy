import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../settings/models/app_currency.dart';
import '../../settings/models/measure_unit.dart';
import '../../settings/providers/settings_providers.dart';
import '../models/proforma_document.dart';
import '../models/proforma_status.dart';
import '../providers/proforma_providers.dart';
import '../widgets/proforma_save_status.dart';
import '../widgets/proforma_table_builder.dart';

class ProformaEditorScreen extends ConsumerStatefulWidget {
  const ProformaEditorScreen({super.key, required this.proformaId});

  static const routePath = '/proformas';

  final int proformaId;

  @override
  ConsumerState<ProformaEditorScreen> createState() =>
      _ProformaEditorScreenState();
}

class _ProformaEditorScreenState extends ConsumerState<ProformaEditorScreen> {
  static const _debounce = Duration(milliseconds: 450);
  static const _documentMountDelay = Duration(seconds: 2);

  final _clientController = TextEditingController();
  final _projectController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime _date = DateTime.now();
  AppCurrency _currency = AppCurrency.pen;
  String _code = '';
  ProformaStatus _status = ProformaStatus.draft;
  ProformaDocument _document = ProformaDocument.empty();

  bool _hydrated = false;
  bool _dirty = false;
  ProformaSaveStatus _saveStatus = ProformaSaveStatus.idle;
  Timer? _debounceTimer;
  int _saveToken = 0;

  /// La tabla no se monta al entrar: cabecera primero, luego loader y tabla.
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
    _clientController.dispose();
    _projectController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _hydrateFrom(Proforma? proforma) {
    if (proforma == null || _hydrated) return;
    _clientController.text = proforma.clientName;
    _projectController.text = proforma.projectName;
    _phoneController.text = proforma.phone ?? '';
    _date = proforma.proformaDate;
    _currency = AppCurrency.fromCode(proforma.currency);
    _code = proforma.code;
    _status = ProformaStatus.fromCode(proforma.status);
    _document = ProformaDocument.fromJsonString(proforma.documentJson);
    _hydrated = true;
    _scheduleDocumentMount();
  }

  void _scheduleDocumentMount() {
    if (_documentMountScheduled || _documentUiReady) return;
    _documentMountScheduled = true;
    // Espera a que el screen (cabecera) pinte, luego loader fijo y montaje.
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
      await ref
          .read(proformaServiceProvider)
          .saveEditorState(
            id: widget.proformaId,
            clientName: _clientController.text,
            projectName: _projectController.text,
            phone: _phoneController.text,
            proformaDate: _date,
            currency: _currency,
            document: _document,
          );
      if (!mounted || token != _saveToken) return;
      _dirty = false;
      setState(() => _saveStatus = ProformaSaveStatus.saved);
      ref.invalidate(proformasListProvider);
    } catch (_) {
      if (!mounted || token != _saveToken) return;
      setState(() => _saveStatus = ProformaSaveStatus.error);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => _date = picked);
    _scheduleSave();
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
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
    final async = ref.watch(proformaByIdProvider(widget.proformaId));
    final prefs = ref.watch(userPreferencesProvider).valueOrNull;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final defaultUnit = prefs?.unit ?? MeasureUnit.m2;

    ref.listen(proformaByIdProvider(widget.proformaId), (previous, next) {
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
        title: Text(_code.isEmpty ? 'Proforma' : _code),
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('No se pudo cargar la proforma')),
        data: (proforma) {
          if (proforma == null) {
            return const Center(child: Text('Proforma no encontrada'));
          }
          _hydrateFrom(proforma);

          final companyName = prefs?.companyName?.trim();
          final logoPath = prefs?.companyLogoPath;
          final hasCompanyName = companyName != null && companyName.isNotEmpty;

          final bottomInset = MediaQuery.paddingOf(context).bottom;
          return ListView(
            // Base + inset del sistema (nav bar / gestos): varía por dispositivo.
            padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottomInset),
            children: [
              AcrylicSurface(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _CompanyLogo(path: logoPath),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasCompanyName
                                    ? companyName
                                    : 'Sin nombre de empresa',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: hasCompanyName
                                      ? null
                                      : colorScheme.onSurface.withValues(
                                          alpha: 0.45,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _code,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.65,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _StatusChip(status: _status),
                      ],
                    ),
                    const SizedBox(height: 18),
                    AppTextField(
                      controller: _clientController,
                      label: 'Cliente',
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      controller: _projectController,
                      label: 'Proyecto',
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      controller: _phoneController,
                      label: 'Teléfono',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Fecha',
                          suffixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        child: Text(
                          _formatDate(_date),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Moneda', style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final item in AppCurrency.values)
                          ChoiceChip(
                            label: Text(item.label),
                            selected: _currency == item,
                            onSelected: (_) {
                              setState(() => _currency = item);
                              _scheduleSave();
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              if (_documentUiReady)
                ProformaTableBuilder(
                  document: _document,
                  defaultUnit: defaultUnit,
                  onChanged: _onDocumentChanged,
                )
              else
                const _DocumentLoadingPanel(),
            ],
          );
        },
      ),
    );
  }
}

class _DocumentLoadingPanel extends StatelessWidget {
  const _DocumentLoadingPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AcrylicSurface(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 36),
      child: Column(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Cargando documento…',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasLogo = path != null && File(path!).existsSync();

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasLogo
          ? Image.file(File(path!), fit: BoxFit.cover)
          : Icon(
              Icons.business_outlined,
              color: colorScheme.onSurface.withValues(alpha: 0.45),
            ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ProformaStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDraft = status == ProformaStatus.draft;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (isDraft ? colorScheme.secondary : colorScheme.primary)
            .withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
