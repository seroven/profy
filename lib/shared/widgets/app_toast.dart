import 'package:flutter/material.dart';

import '../../app/theme/app_motion.dart';
import 'acrylic_surface.dart';

enum AppToastType {
  error,
  success,
  info,
  warning,
}

/// Toast flotante superior, reutilizable en toda la app.
class AppToast {
  AppToast._();

  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    AppToastType type = AppToastType.info,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    double borderRadius = 18,
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 16),
    bool dismissible = true,
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    hide();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) {
        final media = MediaQuery.of(overlayContext);
        return Positioned(
          top: media.padding.top + 12,
          left: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: !dismissible,
            child: Padding(
              padding: margin,
              child: _AppToastCard(
                message: message,
                type: type,
                icon: icon,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                borderRadius: borderRadius,
                duration: duration,
                onDismiss: () {
                  if (_currentEntry == entry) {
                    hide();
                  }
                },
              ),
            ),
          ),
        );
      },
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  static void error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.error,
      duration: duration,
      icon: icon,
    );
  }

  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.success,
      duration: duration,
      icon: icon,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.info,
      duration: duration,
      icon: icon,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.warning,
      duration: duration,
      icon: icon,
    );
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _AppToastCard extends StatefulWidget {
  const _AppToastCard({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    required this.borderRadius,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String message;
  final AppToastType type;
  final Duration duration;
  final VoidCallback onDismiss;
  final double borderRadius;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<_AppToastCard> createState() => _AppToastCardState();
}

class _AppToastCardState extends State<_AppToastCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.normal,
      reverseDuration: AppMotion.fast,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.85),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppMotion.entrance,
        reverseCurve: AppMotion.exit,
      ),
    );
    _fade = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.entrance,
      reverseCurve: AppMotion.exit,
    );

    _controller.forward();
    Future<void>.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted || _dismissing) return;
    _dismissing = true;
    await _controller.reverse();
    if (mounted) widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaults = _toastStyle(colorScheme, widget.type, isDark);
    final tint = widget.backgroundColor ?? defaults.tint;
    final foreground = widget.foregroundColor ?? defaults.foreground;
    final icon = widget.icon ?? defaults.icon;
    final radius = BorderRadius.circular(widget.borderRadius);

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: AcrylicSurface(
                borderRadius: radius,
                blur: 24,
                tint: tint,
                borderColor: defaults.border,
                opacity: defaults.opacity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: InkWell(
                  borderRadius: radius,
                  onTap: _dismiss,
                  child: Row(
                    children: [
                      Icon(icon, color: foreground, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                            color: foreground,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

({
  Color tint,
  Color foreground,
  Color border,
  double opacity,
  IconData icon,
}) _toastStyle(ColorScheme colorScheme, AppToastType type, bool isDark) {
  return switch (type) {
    AppToastType.error => (
        tint: colorScheme.error,
        foreground: isDark ? const Color(0xFFFFDAD6) : const Color(0xFF410002),
        border: colorScheme.error.withValues(alpha: isDark ? 0.45 : 0.35),
        opacity: isDark ? 0.22 : 0.42,
        icon: Icons.error_outline_rounded,
      ),
    AppToastType.success => (
        tint: const Color(0xFF2E7D32),
        foreground: isDark ? const Color(0xFFC8E6C9) : const Color(0xFF1B5E20),
        border: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.45 : 0.35),
        opacity: isDark ? 0.22 : 0.42,
        icon: Icons.check_circle_outline_rounded,
      ),
    AppToastType.warning => (
        tint: const Color(0xFFEF6C00),
        foreground: isDark ? const Color(0xFFFFE0B2) : const Color(0xFF4E342E),
        border: const Color(0xFFEF6C00).withValues(alpha: isDark ? 0.45 : 0.35),
        opacity: isDark ? 0.22 : 0.42,
        icon: Icons.warning_amber_rounded,
      ),
    AppToastType.info => (
        tint: colorScheme.primary,
        foreground: colorScheme.onSurface,
        border: Colors.white.withValues(alpha: isDark ? 0.22 : 0.5),
        opacity: isDark ? 0.16 : 0.45,
        icon: Icons.info_outline_rounded,
      ),
  };
}
