import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_confirm_dialog.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../settings/providers/settings_providers.dart';
import '../../templates/providers/template_providers.dart';
import '../../templates/widgets/template_picker_sheet.dart';
import '../models/proforma_status.dart';
import '../providers/proforma_providers.dart';
import '../widgets/proforma_status_chip.dart';
import 'proforma_editor_screen.dart';

class ProformaScreen extends ConsumerStatefulWidget {
  const ProformaScreen({super.key});

  static const String routeName = 'proformas';
  static const String routePath = '/proformas';

  @override
  ConsumerState<ProformaScreen> createState() => _ProformaScreenState();
}

class _ProformaScreenState extends ConsumerState<ProformaScreen> {
  bool _creating = false;

  Future<void> _create() async {
    if (_creating) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final pick = await showTemplatePickerSheet(context);
    if (pick == null || !mounted) return;

    setState(() => _creating = true);
    try {
      final currency = ref.read(proformaDefaultCurrencyProvider);
      final document = switch (pick) {
        TemplatePickBlank() => null,
        TemplatePickSelected(:final template) => await ref
            .read(templateServiceProvider)
            .materializeForProforma(template),
      };
      final created = await ref.read(proformaServiceProvider).createDraft(
            userId: userId,
            currency: currency,
            document: document,
          );
      ref.invalidate(proformasListProvider);
      if (!mounted) return;
      context.push('${ProformaScreen.routePath}/${created.id}');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo crear la proforma');
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _delete(int id) async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Eliminar proforma',
      description:
          'Se eliminará esta proforma. Esta acción no se puede deshacer.',
      confirmLabel: 'Eliminar',
      cancelLabel: 'Cancelar',
      destructive: true,
    );
    if (!confirmed) return;

    try {
      await ref.read(proformaServiceProvider).softDelete(id);
      ref.invalidate(proformasListProvider);
      if (mounted) AppToast.success(context, 'Proforma eliminada');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo eliminar la proforma');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(proformasListProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final showLoader = _creating ||
        listAsync.isLoading ||
        listAsync.isRefreshing ||
        listAsync.isReloading;

    return ColoredBox(
      color: colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proformas',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Borradores y proformas terminadas',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ),
            ),
            if (showLoader)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppLoadingPanel(
                      message: _creating
                          ? 'Creando proforma…'
                          : 'Cargando proformas…',
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: listAsync.when(
                  skipLoadingOnReload: false,
                  skipLoadingOnRefresh: false,
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AppLoadingPanel(message: 'Cargando proformas…'),
                    ),
                  ),
                  error: (error, stackTrace) => const Center(
                    child: Text('No se pudieron cargar las proformas'),
                  ),
                  data: (items) {
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
                      children: [
                        AppButton(
                          label: 'Nueva proforma',
                          icon: Icons.add_rounded,
                          isLoading: _creating,
                          onPressed: _creating ? null : _create,
                        ),
                        const SizedBox(height: 16),
                        if (items.isEmpty)
                          AcrylicSurface(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Aún no tienes proformas. Crea la primera para empezar.',
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        else
                          ...items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _ProformaListCard(
                                proforma: item,
                                onOpen: () => context.push(
                                  '${ProformaEditorScreen.routePath}/${item.id}',
                                ),
                                onDelete: () => _delete(item.id),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProformaListCard extends StatelessWidget {
  const _ProformaListCard({
    required this.proforma,
    required this.onOpen,
    required this.onDelete,
  });

  final Proforma proforma;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final status = ProformaStatus.fromCode(proforma.status);
    final client = proforma.clientName.trim().isEmpty
        ? 'Sin cliente'
        : proforma.clientName.trim();
    final project = proforma.projectName.trim().isEmpty
        ? 'Sin proyecto'
        : proforma.projectName.trim();
    final meta =
        '${proforma.code} · ${_formatDate(proforma.proformaDate)} · ${proforma.currency}';

    return AcrylicSurface(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        client,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ProformaStatusChip(status: status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  project,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.68),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Eliminar',
                      visualDensity: VisualDensity.compact,
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: colorScheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
