import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../features/auth/providers/auth_provider.dart';
import 'router.dart';
import 'session_lifecycle.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

class ProfyApp extends ConsumerWidget {
  const ProfyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final themeMode = ref.watch(themeModeProvider);
    final colorTheme = ref.watch(appColorThemeProvider);

    final lightTheme = AppTheme.light(colorTheme);
    final darkTheme = AppTheme.dark(colorTheme);

    if (auth.isLoading) {
      return MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final router = ref.watch(routerProvider);

    return SessionLifecycle(
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        routerConfig: router,
      ),
    );
  }
}
