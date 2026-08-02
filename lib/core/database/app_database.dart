import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/payment_methods.dart';
import 'tables/user_details.dart';
import 'tables/user_preferences.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    UserDetails,
    UserPreferences,
    PaymentMethods,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(userDetails);
            await m.createTable(userPreferences);
            await m.createTable(paymentMethods);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'profy');
  }
}
