import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_color_theme.dart';
import '../../../app/theme/theme_provider.dart';
import '../../../core/database/app_database.dart';

void applyPreferencesToThemeReader(
  UserPreference preferences, {
  required T Function<T>(ProviderListenable<T> provider) read,
}) {
  final mode =
      preferences.themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;
  final color = AppColorTheme.values.firstWhere(
    (item) => item.name == preferences.colorTheme,
    orElse: () => AppColorTheme.blue,
  );
  read(themeModeProvider.notifier).setThemeMode(mode);
  read(appColorThemeProvider.notifier).setColorTheme(color);
}
