import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_confirm_dialog.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../proformas/models/proforma_document.dart';
import '../../settings/providers/settings_providers.dart';
import '../providers/template_providers.dart';
import 'template_editor_screen.dart';

class PlantillasScreen extends ConsumerStatefulWidget {
  const PlantillasScreen({super.key});

  static const String routeName = 'plantillas';
  static const String routePath = '/plantillas';

  @override
  ConsumerState<PlantillasScreen> createState() => _PlantillasScreenState();
}

class _PlantillasScreenState extends ConsumerState<PlantillasScreen> {
  bool _creating = false;

  Future<void> _create() async {
    if (_creating) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _creating = true);
    try {
      final created =
          await ref.read(templateServiceProvider).create(userId: userId);
      ref.invalidate(templatesListProvider);
      if (!mounted) return;
      context.push('${PlantillasScreen.routePath}/${created.id}');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo crear la plantilla');
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _delete(int id) async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Eliminar plantilla',
      description:
          'Se eliminará esta plantilla. Las proformas ya creadas no se afectan.',
      confirmLabel: 'Eliminar',
      cancelLabel: 'Cancelar',
      destructive: true,
    );
    if (!confirmed) return;

    try {
      await ref.read(templateServiceProvider).softDelete(id);
      ref.invalidate(templatesListProvider);
      if (mounted) AppToast.success(context, 'Plantilla eliminada');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo eliminar la plantilla');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(templatesListProvider);
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
                    'Plantillas',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Formularios predefinidos para nuevas proformas',
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
                          ? 'Creando plantilla…'
                          : 'Cargando plantillas…',
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
                      child: AppLoadingPanel(message: 'Cargando plantillas…'),
                    ),
                  ),
                  error: (error, stackTrace) => const Center(
                    child: Text('No se pudieron cargar las plantillas'),
                  ),
                  data: (items) {
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
                      children: [
                        AppButton(
                          label: 'Nueva plantilla',
                          icon: Icons.add_rounded,
                          isLoading: _creating,
                          onPressed: _creating ? null : _create,
                        ),
                        const SizedBox(height: 16),
                        if (items.isEmpty)
                          AcrylicSurface(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Aún no tienes plantillas. Crea una para reutilizar '
                              'el cuerpo de tus proformas.',
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        else
                          ...items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _TemplateListCard(
                                template: item,
                                onOpen: () => context.push(
                                  '${TemplateEditorScreen.routePath}/${item.id}',
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

class _TemplateListCard extends StatelessWidget {
  const _TemplateListCard({
    required this.template,
    required this.onOpen,
    required this.onDelete,
  });

  final Template template;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final name =
        template.name.trim().isEmpty ? 'Sin nombre' : template.name.trim();
    final blocks =
        ProformaDocument.fromJsonString(template.documentJson).blocks.length;

    return AcrylicSurface(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        blocks == 0
                            ? 'Sin bloques'
                            : (blocks == 1 ? '1 bloque' : '$blocks bloques'),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
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
          ),
        ),
      ),
    );
  }
}
