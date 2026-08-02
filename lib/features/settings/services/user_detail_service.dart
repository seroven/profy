import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import 'profile_bootstrap_service.dart';

class UserDetailService {
  UserDetailService({
    required this.database,
    required this.bootstrapService,
  });

  final AppDatabase database;
  final ProfileBootstrapService bootstrapService;

  Future<UserDetail> getForUser(int userId) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      return ensured.detail;
    });
  }

  Future<UserDetail> updatePersonalData({
    required int userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? dni,
    String? ruc,
    String? email,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      final now = DateTime.now();

      await (database.update(database.userDetails)
            ..where((t) => t.id.equals(ensured.detail.id)))
          .write(
        UserDetailsCompanion(
          firstName: Value(_emptyToNull(firstName)),
          lastName: Value(_emptyToNull(lastName)),
          phone: Value(_emptyToNull(phone)),
          dni: Value(_emptyToNull(dni)),
          ruc: Value(_emptyToNull(ruc)),
          email: Value(_emptyToNull(email)),
          updatedAt: Value(now),
        ),
      );

      return (await (database.select(database.userDetails)
            ..where((t) => t.id.equals(ensured.detail.id)))
          .getSingle());
    });
  }

  Future<UserDetail> updatePhotoPath({
    required int userId,
    required String? photoPath,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      await (database.update(database.userDetails)
            ..where((t) => t.id.equals(ensured.detail.id)))
          .write(
        UserDetailsCompanion(
          photoPath: Value(photoPath),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return (await (database.select(database.userDetails)
            ..where((t) => t.id.equals(ensured.detail.id)))
          .getSingle());
    });
  }

  String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }
}
