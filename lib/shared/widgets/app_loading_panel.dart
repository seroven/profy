import 'package:flutter/material.dart';

import 'acrylic_surface.dart';

/// Panel acrílico con spinner y mensaje (carga percibida).
class AppLoadingPanel extends StatelessWidget {
  const AppLoadingPanel({
    super.key,
    this.message = 'Cargando…',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AcrylicSurface(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
