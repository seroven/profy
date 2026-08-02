import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/proformas/screens/proforma_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);

  ref.listen(authProvider, (previous, next) {
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

      if (!authState.isAuthenticated && !atAuth) {
        return AuthScreen.routePath;
      }

      if (authState.isAuthenticated && atAuth) {
        return ProformaScreen.routePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AuthScreen.routePath,
        name: AuthScreen.routeName,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: ProformaScreen.routePath,
        name: ProformaScreen.routeName,
        builder: (context, state) => const ProformaScreen(),
      ),
    ],
  );
});
