import 'package:flutter/material.dart';

import 'acrylic_surface.dart';
import 'app_button.dart';

/// Modal de confirmación reutilizable (sí / no) con estilo acrílico.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmLabel = 'Sí',
    this.cancelLabel = 'No',
    this.destructive = false,
    this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String description;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  /// Muestra el diálogo. Retorna `true` si confirma, `false` si cancela.
  /// También invoca [onConfirm] / [onCancel] si se pasan.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String description,
    String confirmLabel = 'Sí',
    String cancelLabel = 'No',
    bool destructive = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AppConfirmDialog(
          title: title,
          description: description,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          destructive: destructive,
          onConfirm: () {
            Navigator.of(dialogContext).pop(true);
            onConfirm?.call();
          },
          onCancel: () {
            Navigator.of(dialogContext).pop(false);
            onCancel?.call();
          },
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: AcrylicSurface(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
        borderRadius: BorderRadius.circular(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.72),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    child: Text(cancelLabel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: destructive
                      ? FilledButton(
                          onPressed: onConfirm,
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.error,
                            foregroundColor: colorScheme.onError,
                          ),
                          child: Text(confirmLabel),
                        )
                      : AppButton(
                          label: confirmLabel,
                          expanded: true,
                          onPressed: onConfirm,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
