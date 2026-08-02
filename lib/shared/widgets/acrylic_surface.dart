import 'dart:ui';

import 'package:flutter/material.dart';

/// Superficie tipo acrílico / glass: blur + tinte + borde luminoso.
class AcrylicSurface extends StatelessWidget {
  const AcrylicSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    this.blur = 22,
    this.tint,
    this.borderColor,
    this.opacity,
    this.shadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final double blur;
  final Color? tint;
  final Color? borderColor;
  final double? opacity;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final tintColor = tint ?? (isDark ? Colors.white : colorScheme.primary);

    final topColor = isDark
        ? tintColor.withValues(alpha: (opacity ?? 0.10) + 0.06)
        : Color.alphaBlend(
            tintColor.withValues(alpha: (opacity ?? 0.14) * 0.55),
            colorScheme.surface.withValues(alpha: 0.88),
          );
    final bottomColor = isDark
        ? tintColor.withValues(alpha: (opacity ?? 0.10) * 0.55)
        : Color.alphaBlend(
            tintColor.withValues(alpha: (opacity ?? 0.14) * 0.28),
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
          );
    final edge = borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.22)
            : colorScheme.outline.withValues(alpha: 0.28));

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: edge, width: 1),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [topColor, bottomColor],
              ),
            ),
            child: padding == null
                ? child
                : Padding(padding: padding!, child: child),
          ),
        ),
      ),
    );
  }
}
