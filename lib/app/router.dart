import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/payments/screens/comprobante_screen.dart';
import '../features/proformas/screens/proforma_editor_screen.dart';
import '../features/proformas/screens/proforma_screen.dart';
import '../features/settings/screens/configuracion_screen.dart';
import '../features/settings/screens/edit_company_logo_screen.dart';
import '../features/settings/screens/edit_password_screen.dart';
import '../features/settings/screens/edit_payment_method_screen.dart';
import '../features/settings/screens/edit_preferences_screen.dart';
import '../features/settings/screens/edit_profile_screen.dart';
import '../features/settings/screens/edit_username_screen.dart';
import '../features/settings/screens/payment_methods_screen.dart';
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
            location: state.uri.path,
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
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final id =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  return buildTabSlidePage(
                    key: state.pageKey,
                    forward: true,
                    child: ProformaEditorScreen(proformaId: id),
                  );
                },
              ),
            ],
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
            routes: [
              GoRoute(
                path: 'perfil',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const EditProfileScreen(),
                ),
              ),
              GoRoute(
                path: 'usuario',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const EditUsernameScreen(),
                ),
              ),
              GoRoute(
                path: 'contrasena',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const EditPasswordScreen(),
                ),
              ),
              GoRoute(
                path: 'preferencias',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const EditPreferencesScreen(),
                ),
              ),
              GoRoute(
                path: 'empresa',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const EditCompanyLogoScreen(),
                ),
              ),
              GoRoute(
                path: 'medios-pago',
                pageBuilder: (context, state) => buildTabSlidePage(
                  key: state.pageKey,
                  forward: true,
                  child: const PaymentMethodsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'nuevo',
                    pageBuilder: (context, state) => buildTabSlidePage(
                      key: state.pageKey,
                      forward: true,
                      child: const EditPaymentMethodScreen(),
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    pageBuilder: (context, state) {
                      final id = int.tryParse(state.pathParameters['id'] ?? '');
                      return buildTabSlidePage(
                        key: state.pageKey,
                        forward: true,
                        child: EditPaymentMethodScreen(methodId: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
