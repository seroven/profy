import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_motion.dart';
import '../../app/theme/theme_switch_controller.dart';

/// Capa sólida durante cambios de modo/color.
/// Evita animar el glass mientras el ThemeData haría lerp.
class ThemeSwitchOverlay extends ConsumerStatefulWidget {
  const ThemeSwitchOverlay({super.key});

  @override
  ConsumerState<ThemeSwitchOverlay> createState() => _ThemeSwitchOverlayState();
}

class _ThemeSwitchOverlayState extends ConsumerState<ThemeSwitchOverlay>
    with TickerProviderStateMixin {
  static const _coverIn = Duration(milliseconds: 280);
  static const _swap = Duration(milliseconds: 520);
  static const _coverOut = Duration(milliseconds: 320);
  static const _hold = Duration(milliseconds: 90);

  static const _darkSurface = Color(0xFF121212);
  static const _lightSurface = Color(0xFFF5F5F7);

  late final AnimationController _coverController;
  late final AnimationController _swapController;

  ThemeSwitchRequest? _active;
  bool _running = false;
  bool _applied = false;

  @override
  void initState() {
    super.initState();
    _coverController = AnimationController(vsync: this, duration: _coverIn);
    _swapController = AnimationController(vsync: this, duration: _swap);
  }

  @override
  void dispose() {
    _coverController.dispose();
    _swapController.dispose();
    super.dispose();
  }

  Future<void> _run(ThemeSwitchRequest request) async {
    if (_running) return;
    _running = true;
    _applied = false;
    _active = request;

    final start = switch (request) {
      ThemeModeSwitchRequest(:final toLight) => toLight ? 0.0 : 1.0,
      ColorThemeSwitchRequest() => 0.0,
    };
    final end = switch (request) {
      ThemeModeSwitchRequest(:final toLight) => toLight ? 1.0 : 0.0,
      ColorThemeSwitchRequest() => 1.0,
    };

    _swapController.value = start;
    _coverController.duration = _coverIn;
    setState(() {});

    await _coverController.forward(from: 0);
    await Future<void>.delayed(_hold);

    ref.read(themeSwitchControllerProvider.notifier).applyUnderCover();
    _applied = true;
    setState(() {});

    await _swapController.animateTo(
      end,
      duration: _swap,
      curve: AppMotion.standard,
    );
    await Future<void>.delayed(_hold);

    _coverController.duration = _coverOut;
    await _coverController.reverse();

    _active = null;
    _running = false;
    _applied = false;
    if (mounted) setState(() {});
    ref.read(themeSwitchControllerProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ThemeSwitchRequest?>(themeSwitchControllerProvider, (
      previous,
      next,
    ) {
      if (next != null && previous == null) {
        _run(next);
      }
    });

    if (_active == null && !_running && _coverController.isDismissed) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_coverController, _swapController]),
      builder: (context, child) {
        final cover = _coverController.value;
        if (cover <= 0.001 && !_running) {
          return const SizedBox.shrink();
        }

        final request = _active;
        final t = _swapController.value;

        return Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: cover.clamp(0.0, 1.0),
              child: switch (request) {
                ThemeModeSwitchRequest(:final from) => _ModeCover(
                    progress: t,
                    applied: _applied,
                    fromDark: from == ThemeMode.dark,
                    darkSurface: _darkSurface,
                    lightSurface: _lightSurface,
                  ),
                ColorThemeSwitchRequest(
                  :final from,
                  :final to,
                  :final brightness,
                ) =>
                  _ColorCover(
                    progress: t,
                    applied: _applied,
                    from: from.seedColor,
                    to: to.seedColor,
                    surface: brightness == Brightness.dark
                        ? _darkSurface
                        : _lightSurface,
                  ),
                null => ColoredBox(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? _darkSurface
                        : _lightSurface,
                  ),
              },
            ),
          ),
        );
      },
    );
  }
}

class _ModeCover extends StatelessWidget {
  const _ModeCover({
    required this.progress,
    required this.applied,
    required this.fromDark,
    required this.darkSurface,
    required this.lightSurface,
  });

  final double progress;
  final bool applied;
  final bool fromDark;
  final Color darkSurface;
  final Color lightSurface;

  @override
  Widget build(BuildContext context) {
    final solid = applied
        ? Color.lerp(darkSurface, lightSurface, progress)!
        : (fromDark ? darkSurface : lightSurface);

    final showSun = progress >= 0.5;
    final iconOpacity = showSun
        ? ((progress - 0.5) * 2).clamp(0.0, 1.0)
        : ((0.5 - progress) * 2).clamp(0.0, 1.0);
    final iconScale = 0.72 + (0.28 * iconOpacity);
    final iconTurn =
        (showSun ? progress - 0.5 : 0.5 - progress) * 0.4;

    return ColoredBox(
      color: solid,
      child: Center(
        child: Transform.rotate(
          angle: iconTurn * math.pi,
          child: Transform.scale(
            scale: iconScale,
            child: Opacity(
              opacity: iconOpacity.clamp(0.15, 1.0),
              child: CustomPaint(
                size: const Size(88, 88),
                painter: showSun ? const _SunPainter() : const _MoonPainter(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorCover extends StatelessWidget {
  const _ColorCover({
    required this.progress,
    required this.applied,
    required this.from,
    required this.to,
    required this.surface,
  });

  final double progress;
  final bool applied;
  final Color from;
  final Color to;
  final Color surface;

  @override
  Widget build(BuildContext context) {
    final accent = applied ? Color.lerp(from, to, progress)! : from;
    final scale = applied ? (0.55 + (0.45 * progress)) : 0.55;
    final ring = Color.lerp(from, to, applied ? progress : 0)!;

    return ColoredBox(
      color: surface,
      child: Center(
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: 112,
            height: 112,
            child: CustomPaint(
              painter: _ColorOrbPainter(
                fill: accent,
                ring: ring.withValues(alpha: 0.35),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorOrbPainter extends CustomPainter {
  const _ColorOrbPainter({
    required this.fill,
    required this.ring,
  });

  final Color fill;
  final Color ring;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.36;

    canvas.drawCircle(
      center,
      radius * 1.28,
      Paint()
        ..color = ring
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.shortestSide * 0.06,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color.lerp(fill, Colors.white, 0.22)!,
            fill,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(covariant _ColorOrbPainter oldDelegate) {
    return oldDelegate.fill != fill || oldDelegate.ring != ring;
  }
}

class _SunPainter extends CustomPainter {
  const _SunPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.22;
    final paint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);

    final rayPaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..strokeWidth = size.shortestSide * 0.055
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final inner = radius * 1.45;
    final outer = radius * 2.05;
    for (var i = 0; i < 8; i++) {
      final angle = (i / 8) * math.pi * 2;
      final from = Offset(
        center.dx + math.cos(angle) * inner,
        center.dy + math.sin(angle) * inner,
      );
      final to = Offset(
        center.dx + math.cos(angle) * outer,
        center.dy + math.sin(angle) * outer,
      );
      canvas.drawLine(from, to, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SunPainter oldDelegate) => false;
}

class _MoonPainter extends CustomPainter {
  const _MoonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.34;

    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    final cut = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(center.dx + radius * 0.38, center.dy - radius * 0.12),
          radius: radius * 0.92,
        ),
      );

    final moon = Path.combine(PathOperation.difference, path, cut);
    canvas.drawPath(
      moon,
      Paint()
        ..color = const Color(0xFFE8EAF0)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _MoonPainter oldDelegate) => false;
}
