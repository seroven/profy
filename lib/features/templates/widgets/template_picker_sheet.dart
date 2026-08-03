import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../providers/template_providers.dart';

sealed class TemplatePickResult {
  const TemplatePickResult();
}

class TemplatePickBlank extends TemplatePickResult {
  const TemplatePickBlank();
}

class TemplatePickSelected extends TemplatePickResult {
  const TemplatePickSelected(this.template);
  final Template template;
}

/// `null` = cancelado; [TemplatePickBlank] / [TemplatePickSelected] = confirmado.
Future<TemplatePickResult?> showTemplatePickerSheet(BuildContext context) {
  return showDialog<TemplatePickResult>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (context) => const _TemplatePickerDialog(),
  );
}

class _TemplatePickerDialog extends ConsumerWidget {
  const _TemplatePickerDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(templatesListProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.62;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: AcrylicSurface(
        borderRadius: BorderRadius.circular(22),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Nueva proforma',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Elige una plantilla o empieza en blanco',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.72),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.note_add_outlined,
                    color: colorScheme.primary,
                  ),
                  title: const Text('En blanco'),
                  subtitle: const Text('Documento vacío'),
                  onTap: () => Navigator.of(context).pop(
                    const TemplatePickBlank(),
                  ),
                ),
                Divider(
                  height: 20,
                  color: colorScheme.outline.withValues(alpha: 0.25),
                ),
                Flexible(
                  child: templatesAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: AppLoadingPanel(message: 'Cargando plantillas…'),
                    ),
                    error: (error, stackTrace) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('No se pudieron cargar las plantillas'),
                    ),
                    data: (templates) {
                      if (templates.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'No hay plantillas registradas.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.65),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: templates.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 2),
                        itemBuilder: (context, index) {
                          final template = templates[index];
                          final name = template.name.trim().isEmpty
                              ? 'Sin nombre'
                              : template.name.trim();
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.dashboard_customize_outlined,
                              color: colorScheme.primary,
                            ),
                            title: Text(name),
                            onTap: () => Navigator.of(context).pop(
                              TemplatePickSelected(template),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
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
