import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_color_theme.dart';

/// Modo de tema actual. Persistencia se añadirá más adelante.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;

  void setThemeMode(ThemeMode mode) => state = mode;

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Color de acento actual. Persistencia se añadirá más adelante.
class AppColorThemeNotifier extends Notifier<AppColorTheme> {
  @override
  AppColorTheme build() => AppColorTheme.blue;

  void setColorTheme(AppColorTheme theme) => state = theme;
}

final appColorThemeProvider =
    NotifierProvider<AppColorThemeNotifier, AppColorTheme>(
  AppColorThemeNotifier.new,
);
