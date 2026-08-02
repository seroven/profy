import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

class ProfyApp extends ConsumerWidget {
  const ProfyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final colorTheme = ref.watch(appColorThemeProvider);

    return MaterialApp.router(
      title: 'Profy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(colorTheme),
      darkTheme: AppTheme.dark(colorTheme),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
