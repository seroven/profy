import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/auth_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AuthScreen.routePath,
    routes: [
      GoRoute(
        path: AuthScreen.routePath,
        name: AuthScreen.routeName,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
});
