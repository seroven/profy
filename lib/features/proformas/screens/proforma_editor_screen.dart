import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_confirm_dialog.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../settings/models/app_currency.dart';
import '../../settings/models/measure_unit.dart';
import '../../settings/providers/settings_providers.dart';
import '../models/proforma_document.dart';
import '../models/proforma_status.dart';
import '../providers/proforma_providers.dart';
import '../widgets/proforma_save_status.dart';
import '../widgets/proforma_status_chip.dart';
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
  bool _actionBusy = false;
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
    if (!_hydrated || _actionBusy || _status == ProformaStatus.finished) {
      return;
    }
    _dirty = true;
    setState(() => _saveStatus = ProformaSaveStatus.pending);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, () => _persist());
  }

  void _onDocumentChanged(ProformaDocument document) {
    if (_status == ProformaStatus.finished) return;
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
      ref.invalidate(proformaByIdProvider(widget.proformaId));
    } catch (_) {
      if (!mounted || token != _saveToken) return;
      setState(() => _saveStatus = ProformaSaveStatus.error);
    }
  }

  Future<void> _saveNow() async {
    if (!_hydrated || _actionBusy) return;
    await _persist(immediate: true);
    if (!mounted) return;
    if (_saveStatus == ProformaSaveStatus.saved) {
      AppToast.success(context, 'Proforma guardada');
    } else if (_saveStatus == ProformaSaveStatus.error) {
      AppToast.error(context, 'No se pudo guardar');
    }
  }

  Future<void> _finishProforma() async {
    if (!_hydrated || _actionBusy) return;
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Guardar y terminar',
      description:
          'La proforma pasará a estado Terminada. Podrás reabrirla como borrador si necesitas editarla después.',
      confirmLabel: 'Terminar',
      cancelLabel: 'Cancelar',
      destructive: false,
    );
    if (!confirmed || !mounted) return;

    setState(() => _actionBusy = true);
    try {
      await _persist(immediate: true);
      if (!mounted) return;
      if (_saveStatus == ProformaSaveStatus.error) {
        AppToast.error(context, 'No se pudo guardar antes de terminar');
        return;
      }
      await ref.read(proformaServiceProvider).markFinished(widget.proformaId);
      if (!mounted) return;
      setState(() => _status = ProformaStatus.finished);
      ref.invalidate(proformasListProvider);
      ref.invalidate(proformaByIdProvider(widget.proformaId));
      AppToast.success(context, 'Proforma terminada');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo terminar la proforma');
      }
    } finally {
      if (mounted) setState(() => _actionBusy = false);
    }
  }

  Future<void> _reopenAsDraft() async {
    if (!_hydrated || _actionBusy) return;
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Reabrir como borrador',
      description:
          'La proforma volverá a estado Borrador y podrás seguir editándola.',
      confirmLabel: 'Reabrir',
      cancelLabel: 'Cancelar',
    );
    if (!confirmed || !mounted) return;

    setState(() => _actionBusy = true);
    try {
      await ref.read(proformaServiceProvider).markDraft(widget.proformaId);
      if (!mounted) return;
      setState(() => _status = ProformaStatus.draft);
      ref.invalidate(proformasListProvider);
      ref.invalidate(proformaByIdProvider(widget.proformaId));
      AppToast.success(context, 'Proforma reabierta como borrador');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo reabrir la proforma');
      }
    } finally {
      if (mounted) setState(() => _actionBusy = false);
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
                        ProformaStatusChip(status: _status),
                      ],
                    ),
                    const SizedBox(height: 18),
                    AppTextField(
                      controller: _clientController,
                      label: 'Cliente',
                      textInputAction: TextInputAction.next,
                      enabled: _status == ProformaStatus.draft,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      controller: _projectController,
                      label: 'Proyecto',
                      textInputAction: TextInputAction.next,
                      enabled: _status == ProformaStatus.draft,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      controller: _phoneController,
                      label: 'Teléfono',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      enabled: _status == ProformaStatus.draft,
                      onChanged: (_) => _scheduleSave(),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _status == ProformaStatus.draft ? _pickDate : null,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Fecha',
                          suffixIcon: _status == ProformaStatus.draft
                              ? const Icon(Icons.calendar_today_outlined)
                              : null,
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
                            onSelected: _status == ProformaStatus.draft
                                ? (_) {
                                    setState(() => _currency = item);
                                    _scheduleSave();
                                  }
                                : null,
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
                  readOnly: _status == ProformaStatus.finished,
                  onChanged: _onDocumentChanged,
                )
              else
                const AppLoadingPanel(message: 'Cargando documento…'),
              const SizedBox(height: 28),
              if (_status == ProformaStatus.draft) ...[
                OutlinedButton.icon(
                  onPressed: _actionBusy ? null : _saveNow,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Guardar'),
                ),
                const SizedBox(height: 10),
                AppButton(
                  label: 'Guardar y terminar',
                  icon: Icons.check_circle_outline_rounded,
                  isLoading: _actionBusy,
                  onPressed: _actionBusy ? null : _finishProforma,
                ),
              ] else ...[
                Text(
                  'Esta proforma está terminada. Puedes reabrirla si necesitas editarla.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Reabrir como borrador',
                  icon: Icons.lock_open_rounded,
                  isLoading: _actionBusy,
                  onPressed: _actionBusy ? null : _reopenAsDraft,
                ),
              ],
            ],
          );
        },
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

