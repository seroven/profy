import 'package:drift/drift.dart';

import 'table_mixins.dart';
import 'users.dart';

class UserDetails extends Table with Auditable {
  IntColumn get userId => integer().unique().references(Users, #id)();

  TextColumn get firstName => text().named('first_name').nullable()();

  TextColumn get lastName => text().named('last_name').nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get dni => text().nullable()();

  TextColumn get ruc => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get photoPath => text().named('photo_path').nullable()();
}
