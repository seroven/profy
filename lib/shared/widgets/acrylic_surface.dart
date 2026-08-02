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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tintColor = tint ?? (isDark ? Colors.white : Colors.white);
    final fillOpacity = opacity ?? (isDark ? 0.10 : 0.48);
    final edge = borderColor ??
        Colors.white.withValues(alpha: isDark ? 0.22 : 0.55);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.10),
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
                colors: [
                  tintColor.withValues(alpha: fillOpacity + (isDark ? 0.06 : 0.14)),
                  tintColor.withValues(alpha: fillOpacity * 0.55),
                ],
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
