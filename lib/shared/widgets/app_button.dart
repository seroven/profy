import 'package:flutter/material.dart';

import '../../app/theme/app_motion.dart';
import 'acrylic_surface.dart';

/// Botón primario con identidad acrílica / glass.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;
  final IconData? icon;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  void _setPressed(bool value) {
    if (!_enabled || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final radius = BorderRadius.circular(16);

    final child = AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: AppMotion.fast,
      curve: AppMotion.standard,
      child: AnimatedOpacity(
        opacity: _enabled ? 1 : 0.55,
        duration: AppMotion.fast,
        child: AcrylicSurface(
          borderRadius: radius,
          blur: 18,
          shadow: true,
          tint: colorScheme.primary,
          borderColor: colorScheme.primary.withValues(
            alpha: isDark ? 0.55 : 0.40,
          ),
          opacity: isDark ? 0.28 : 0.38,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: radius,
              onTap: _enabled ? widget.onPressed : null,
              onHighlightChanged: _setPressed,
              splashColor: colorScheme.primary.withValues(alpha: 0.18),
              highlightColor: colorScheme.primary.withValues(alpha: 0.10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize:
                      widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    if (widget.isLoading)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: colorScheme.onSurface,
                        ),
                      )
                    else ...[
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 20,
                          color: colorScheme.onSurface,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        widget.label,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!widget.expanded) return child;
    return SizedBox(width: double.infinity, child: child);
  }
}
