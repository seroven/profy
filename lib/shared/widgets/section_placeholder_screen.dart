import 'package:flutter/material.dart';

/// Placeholder temporal para secciones aún no implementadas.
class SectionPlaceholderScreen extends StatelessWidget {
  const SectionPlaceholderScreen({
    super.key,
    required this.name,
    this.footer,
  });

  final String name;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$name Screen',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (footer != null) ...[
                const SizedBox(height: 28),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
