import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/password_hasher.dart';

class AccountService {
  AccountService({
    required this.database,
    required this.passwordHasher,
  });

  final AppDatabase database;
  final PasswordHasher passwordHasher;

  Future<void> updateUsername({
    required int userId,
    required String username,
  }) {
    return withMinDuration(() async {
      final normalized = username.trim();
      if (normalized.length < AppConstants.minUsernameLength) {
        throw AuthException(
          'El usuario debe tener al menos ${AppConstants.minUsernameLength} caracteres',
        );
      }

      final existing = await (database.select(database.users)
            ..where(
              (t) => t.username.equals(normalized) & t.id.isNotValue(userId),
            ))
          .getSingleOrNull();
      if (existing != null) {
        throw AuthException('Ese nombre de usuario ya está en uso');
      }

      await (database.update(database.users)..where((t) => t.id.equals(userId)))
          .write(
        UsersCompanion(
          username: Value(normalized),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> updatePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) {
    return withMinDuration(() async {
      final user = await (database.select(database.users)
            ..where((t) => t.id.equals(userId)))
          .getSingle();

      if (!passwordHasher.verify(currentPassword, user.password)) {
        throw AuthException('La contraseña actual no es correcta');
      }
      if (newPassword.length < AppConstants.minPasswordLength) {
        throw AuthException(
          'La nueva contraseña debe tener al menos ${AppConstants.minPasswordLength} caracteres',
        );
      }

      await (database.update(database.users)..where((t) => t.id.equals(userId)))
          .write(
        UsersCompanion(
          password: Value(passwordHasher.hash(newPassword)),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }
}
