import 'dart:ui';

import 'package:flutter/material.dart';

/// Fondo atmosférico para que el acrílico del login se lea con claridad.
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface,
                Color.lerp(
                      colorScheme.surface,
                      colorScheme.primary,
                      isDark ? 0.34 : 0.22,
                    ) ??
                    colorScheme.surface,
                Color.lerp(
                      colorScheme.surface,
                      colorScheme.tertiary,
                      isDark ? 0.22 : 0.14,
                    ) ??
                    colorScheme.surface,
                colorScheme.surface,
              ],
              stops: const [0, 0.35, 0.7, 1],
            ),
          ),
        ),
        Positioned(
          top: -100,
          right: -60,
          child: _BlurOrb(
            size: 280,
            color: colorScheme.primary.withValues(alpha: isDark ? 0.42 : 0.28),
          ),
        ),
        Positioned(
          bottom: -90,
          left: -70,
          child: _BlurOrb(
            size: 300,
            color: colorScheme.tertiary.withValues(alpha: isDark ? 0.30 : 0.20),
          ),
        ),
        Positioned(
          top: 220,
          left: -40,
          child: _BlurOrb(
            size: 160,
            color: colorScheme.secondary.withValues(alpha: isDark ? 0.22 : 0.16),
          ),
        ),
        Positioned(
          bottom: 140,
          right: -30,
          child: _BlurOrb(
            size: 140,
            color: colorScheme.primary.withValues(alpha: isDark ? 0.18 : 0.12),
          ),
        ),
        // Velo suave para unificar capas.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface.withValues(alpha: isDark ? 0.15 : 0.08),
                Colors.transparent,
                colorScheme.surface.withValues(alpha: isDark ? 0.28 : 0.12),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}
