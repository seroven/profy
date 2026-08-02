import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../settings/providers/settings_providers.dart';
import '../models/proforma_status.dart';
import '../providers/proforma_providers.dart';
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

    setState(() => _creating = true);
    try {
      final currency = ref.read(proformaDefaultCurrencyProvider);
      final created = await ref.read(proformaServiceProvider).createDraft(
            userId: userId,
            currency: currency,
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
        child: showLoader
            ? const Center(child: CircularProgressIndicator())
            : listAsync.when(
                skipLoadingOnReload: false,
                skipLoadingOnRefresh: false,
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => const Center(
                  child: Text('No se pudieron cargar las proformas'),
                ),
                data: (items) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
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
                      const SizedBox(height: 18),
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
                        ...items.map((item) {
                          final status =
                              ProformaStatus.fromCode(item.status);
                          final title = item.clientName.trim().isEmpty
                              ? 'Sin cliente'
                              : item.clientName.trim();
                          final project = item.projectName.trim().isEmpty
                              ? 'Sin proyecto'
                              : item.projectName.trim();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AcrylicSurface(
                              child: ListTile(
                                onTap: () => context.push(
                                  '${ProformaEditorScreen.routePath}/${item.id}',
                                ),
                                title: Text(title),
                                subtitle: Text(
                                  '${item.code} · $project · ${status.label}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                  ),
                                  onPressed: () => _delete(item.id),
                                ),
                              ),
                            ),
                          );
                        }),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
