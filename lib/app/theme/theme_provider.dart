import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_color_theme.dart';

/// Modo de tema actual (persistido en user_preferences).
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    // Solo claro/oscuro en este producto.
    state = mode == ThemeMode.light ? ThemeMode.light : ThemeMode.dark;
  }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Color de acento actual (persistido en user_preferences).
class AppColorThemeNotifier extends Notifier<AppColorTheme> {
  @override
  AppColorTheme build() => AppColorTheme.blue;

  void setColorTheme(AppColorTheme theme) => state = theme;
}

final appColorThemeProvider =
    NotifierProvider<AppColorThemeNotifier, AppColorTheme>(
  AppColorThemeNotifier.new,
);
