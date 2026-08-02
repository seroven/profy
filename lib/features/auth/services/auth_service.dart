import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import 'password_hasher.dart';
import 'session_service.dart';

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthBootstrap {
  const AuthBootstrap({
    required this.needsSetup,
    this.user,
  });

  final bool needsSetup;
  final User? user;
}

class AuthService {
  AuthService({
    required this.database,
    required this.passwordHasher,
    required this.sessionService,
  });

  final AppDatabase database;
  final PasswordHasher passwordHasher;
  final SessionService sessionService;

  /// Carga inicial (lectura BD + sesión) con duración mínima percibida.
  Future<AuthBootstrap> bootstrap() {
    return withMinDuration(() async {
      final needsSetup = !(await hasUsers());
      final user = await restoreSession();
      return AuthBootstrap(needsSetup: needsSetup, user: user);
    });
  }

  Future<bool> hasUsers() async {
    final existing =
        await (database.select(database.users)..limit(1)).getSingleOrNull();
    return existing != null;
  }

  Future<User?> restoreSession() async {
    final userId = await sessionService.getValidUserId();
    if (userId == null) return null;

    final user = await (database.select(database.users)
          ..where((t) => t.id.equals(userId) & t.enable.equals(true)))
        .getSingleOrNull();

    if (user == null) {
      await sessionService.clear();
      return null;
    }

    await sessionService.touch();
    return user;
  }

  /// Primer acceso sin usuarios: crea la cuenta. Si ya hay usuario: valida login.
  Future<User> loginOrRegister({
    required String username,
    required String password,
  }) {
    return withMinDuration(() async {
      final normalizedUsername = username.trim();
      final usersExist = await hasUsers();

      if (!usersExist) {
        return _registerFirstUser(
          username: normalizedUsername,
          password: password,
        );
      }

      return _login(username: normalizedUsername, password: password);
    });
  }

  Future<User> _registerFirstUser({
    required String username,
    required String password,
  }) async {
    final hashed = passwordHasher.hash(password);

    final userId = await database.into(database.users).insert(
          UsersCompanion.insert(
            username: username,
            password: hashed,
            userCreate: const Value(null),
            userUpdate: const Value(null),
          ),
        );

    final user = await (database.select(database.users)
          ..where((t) => t.id.equals(userId)))
        .getSingle();

    await sessionService.saveSession(user.id);
    return user;
  }

  Future<User> _login({
    required String username,
    required String password,
  }) async {
    final user = await (database.select(database.users)
          ..where(
            (t) => t.username.equals(username) & t.enable.equals(true),
          ))
        .getSingleOrNull();

    if (user == null || !passwordHasher.verify(password, user.password)) {
      throw AuthException('Usuario o contraseña incorrectos');
    }

    await sessionService.saveSession(user.id);
    return user;
  }

  Future<void> logout() {
    return withMinDuration(() async {
      await sessionService.clear();
    });
  }

  Future<void> touchSession() => sessionService.touch();
}
