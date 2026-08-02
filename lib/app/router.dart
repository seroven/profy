import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/payments/screens/comprobante_screen.dart';
import '../features/proformas/screens/proforma_screen.dart';
import '../features/settings/screens/configuracion_screen.dart';
import '../features/templates/screens/plantillas_screen.dart';
import 'navigation/app_tab.dart';
import 'navigation/tab_slide_page.dart';
import 'shell/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);

  ref.listen(authProvider, (previous, next) {
    final wasAuth = previous?.valueOrNull?.isAuthenticated ?? false;
    final isAuth = next.valueOrNull?.isAuthenticated ?? false;
    if (!wasAuth && isAuth) {
      TabSlideDirection.reset();
    }
    refresh.value++;
  });

  return GoRouter(
    initialLocation: AuthScreen.routePath,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      if (auth.isLoading) return null;

      final authState = auth.valueOrNull;
      if (authState == null) return AuthScreen.routePath;

      final atAuth = state.matchedLocation == AuthScreen.routePath;
      final inApp = AppTab.fromLocation(state.matchedLocation) != null;

      if (!authState.isAuthenticated && !atAuth) {
        return AuthScreen.routePath;
      }

      if (authState.isAuthenticated && atAuth) {
        return AppTab.proformas.routePath;
      }

      if (authState.isAuthenticated && !inApp && !atAuth) {
        return AppTab.proformas.routePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AuthScreen.routePath,
        name: AuthScreen.routeName,
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(
            location: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: ProformaScreen.routePath,
            name: ProformaScreen.routeName,
            pageBuilder: (context, state) {
              final forward =
                  TabSlideDirection.resolveForward(AppTab.proformas);
              return buildTabSlidePage(
                key: state.pageKey,
                forward: forward,
                child: const ProformaScreen(),
              );
            },
          ),
          GoRoute(
            path: ComprobanteScreen.routePath,
            name: ComprobanteScreen.routeName,
            pageBuilder: (context, state) {
              final forward =
                  TabSlideDirection.resolveForward(AppTab.comprobantes);
              return buildTabSlidePage(
                key: state.pageKey,
                forward: forward,
                child: const ComprobanteScreen(),
              );
            },
          ),
          GoRoute(
            path: PlantillasScreen.routePath,
            name: PlantillasScreen.routeName,
            pageBuilder: (context, state) {
              final forward =
                  TabSlideDirection.resolveForward(AppTab.plantillas);
              return buildTabSlidePage(
                key: state.pageKey,
                forward: forward,
                child: const PlantillasScreen(),
              );
            },
          ),
          GoRoute(
            path: ConfiguracionScreen.routePath,
            name: ConfiguracionScreen.routeName,
            pageBuilder: (context, state) {
              final forward =
                  TabSlideDirection.resolveForward(AppTab.configuracion);
              return buildTabSlidePage(
                key: state.pageKey,
                forward: forward,
                child: const ConfiguracionScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );
});
