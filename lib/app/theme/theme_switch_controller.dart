import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_color_theme.dart';
import 'theme_provider.dart';

/// Pedido de transición visual (modo o color) bajo overlay sólido.
sealed class ThemeSwitchRequest {
  const ThemeSwitchRequest();
}

class ThemeModeSwitchRequest extends ThemeSwitchRequest {
  const ThemeModeSwitchRequest({
    required this.from,
    required this.to,
  });

  final ThemeMode from;
  final ThemeMode to;

  bool get toLight => to == ThemeMode.light;
}

class ColorThemeSwitchRequest extends ThemeSwitchRequest {
  const ColorThemeSwitchRequest({
    required this.from,
    required this.to,
    required this.brightness,
  });

  final AppColorTheme from;
  final AppColorTheme to;
  final Brightness brightness;
}

/// Orquesta cambios de apariencia detrás de un overlay sólido.
class ThemeSwitchController extends Notifier<ThemeSwitchRequest?> {
  Completer<void>? _completer;

  @override
  ThemeSwitchRequest? build() => null;

  bool get isActive => state != null;

  Future<void> switchMode(ThemeMode mode) async {
    final next = mode == ThemeMode.light ? ThemeMode.light : ThemeMode.dark;
    final current = ref.read(themeModeProvider);
    if (next == current || _completer != null) return;

    _completer = Completer<void>();
    state = ThemeModeSwitchRequest(from: current, to: next);
    await _completer!.future;
  }

  Future<void> switchColor(AppColorTheme theme) async {
    final current = ref.read(appColorThemeProvider);
    if (theme == current || _completer != null) return;

    final mode = ref.read(themeModeProvider);
    final brightness =
        mode == ThemeMode.light ? Brightness.light : Brightness.dark;

    _completer = Completer<void>();
    state = ColorThemeSwitchRequest(
      from: current,
      to: theme,
      brightness: brightness,
    );
    await _completer!.future;
  }

  /// Aplica el cambio real cuando el overlay ya cubre la UI.
  void applyUnderCover() {
    final request = state;
    switch (request) {
      case ThemeModeSwitchRequest(:final to):
        ref.read(themeModeProvider.notifier).setThemeMode(to);
      case ColorThemeSwitchRequest(:final to):
        ref.read(appColorThemeProvider.notifier).setColorTheme(to);
      case null:
        break;
    }
  }

  void complete() {
    state = null;
    final completer = _completer;
    _completer = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
  }
}

final themeSwitchControllerProvider =
    NotifierProvider<ThemeSwitchController, ThemeSwitchRequest?>(
  ThemeSwitchController.new,
);
