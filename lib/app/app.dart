import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../features/auth/providers/auth_provider.dart';
import '../shared/widgets/theme_switch_overlay.dart';
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

    // Mantiene el splash nativo hasta saber si va a auth o proformas.
    if (auth.isLoading) {
      return MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: const Scaffold(
          backgroundColor: Colors.black,
          body: SizedBox.shrink(),
        ),
      );
    }

    final router = ref.watch(routerProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    // themeAnimationDuration en cero: el cambio real ocurre bajo el overlay
    // sólido, sin lerp costoso del glass.
    return SessionLifecycle(
      child: Stack(
        textDirection: TextDirection.ltr,
        children: [
          MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            themeAnimationDuration: Duration.zero,
            routerConfig: router,
          ),
          const ThemeSwitchOverlay(),
        ],
      ),
    );
  }
}
