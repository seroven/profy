import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/database/database_provider.dart';
import '../../settings/providers/settings_service_providers.dart';
import '../../settings/providers/theme_sync.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';
import '../services/password_hasher.dart';
import '../services/session_service.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final sessionServiceProvider = FutureProvider<SessionService>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SessionService(prefs);
});

final authServiceProvider = FutureProvider<AuthService>((ref) async {
  final database = ref.watch(databaseProvider);
  final sessionService = await ref.watch(sessionServiceProvider.future);
  return AuthService(
    database: database,
    passwordHasher: PasswordHasher(),
    sessionService: sessionService,
  );
});

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final service = await ref.watch(authServiceProvider.future);
    final bootstrap = await service.bootstrap();

    if (bootstrap.user != null) {
      await _ensureProfileAndTheme(bootstrap.user!.id);
      return AuthState(
        isAuthenticated: true,
        needsSetup: false,
        user: bootstrap.user,
      );
    }

    return AuthState.unauthenticated(needsSetup: bootstrap.needsSetup);
  }

  Future<void> _ensureProfileAndTheme(int userId) async {
    final ensured =
        await ref.read(profileBootstrapServiceProvider).ensureForUser(userId);
    applyPreferencesToThemeReader(ref, ensured.preferences);
  }

  /// Retorna mensaje de error o `null` si el acceso fue exitoso.
  Future<String?> loginOrRegister({
    required String username,
    required String password,
  }) async {
    final service = await ref.read(authServiceProvider.future);

    try {
      final user = await service.loginOrRegister(
        username: username,
        password: password,
      );
      await _ensureProfileAndTheme(user.id);
      state = AsyncData(
        AuthState(
          isAuthenticated: true,
          needsSetup: false,
          user: user,
        ),
      );
      return null;
    } on AuthException catch (error) {
      return error.message;
    } catch (_) {
      return 'No se pudo completar el acceso. Intenta de nuevo.';
    }
  }

  Future<void> logout() async {
    final service = await ref.read(authServiceProvider.future);
    await service.logout();
    final needsSetup = !(await service.hasUsers());
    state = AsyncData(AuthState.unauthenticated(needsSetup: needsSetup));
  }

  Future<void> reloadUser() async {
    final current = state.valueOrNull;
    final userId = current?.user?.id;
    if (current == null || userId == null) return;

    final database = ref.read(databaseProvider);
    final user = await (database.select(database.users)
          ..where((t) => t.id.equals(userId)))
        .getSingle();

    state = AsyncData(
      current.copyWith(
        isAuthenticated: true,
        needsSetup: false,
        user: user,
      ),
    );
  }

  Future<void> touchSession() async {
    final current = state.valueOrNull;
    if (current == null || !current.isAuthenticated) return;

    final service = await ref.read(authServiceProvider.future);
    await service.touchSession();
  }

  Future<void> ensureSessionValid() async {
    final current = state.valueOrNull;
    if (current == null || !current.isAuthenticated) return;

    final service = await ref.read(authServiceProvider.future);
    final user = await service.restoreSession();
    if (user == null) {
      final needsSetup = !(await service.hasUsers());
      state = AsyncData(AuthState.unauthenticated(needsSetup: needsSetup));
    }
  }
}
