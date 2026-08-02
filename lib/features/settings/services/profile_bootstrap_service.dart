import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Garantiza user_detail + user_preferences 1:1 para un usuario.
class ProfileBootstrapService {
  ProfileBootstrapService(this.database);

  final AppDatabase database;

  Future<({UserDetail detail, UserPreference preferences})> ensureForUser(
    int userId,
  ) async {
    var detail = await (database.select(database.userDetails)
          ..where((t) => t.userId.equals(userId) & t.enable.equals(true)))
        .getSingleOrNull();

    if (detail == null) {
      final detailId = await database.into(database.userDetails).insert(
            UserDetailsCompanion.insert(
              userId: userId,
              userCreate: const Value(null),
              userUpdate: const Value(null),
            ),
          );
      detail = await (database.select(database.userDetails)
            ..where((t) => t.id.equals(detailId)))
          .getSingle();
    }

    var preferences = await (database.select(database.userPreferences)
          ..where(
            (t) => t.userDetailId.equals(detail!.id) & t.enable.equals(true),
          ))
        .getSingleOrNull();

    if (preferences == null) {
      final preferencesId =
          await database.into(database.userPreferences).insert(
                UserPreferencesCompanion.insert(
                  userDetailId: detail.id,
                  userCreate: const Value(null),
                  userUpdate: const Value(null),
                ),
              );
      preferences = await (database.select(database.userPreferences)
            ..where((t) => t.id.equals(preferencesId)))
          .getSingle();
    }

    return (detail: detail, preferences: preferences);
  }
}
