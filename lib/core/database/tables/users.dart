import 'package:drift/drift.dart';

import 'table_mixins.dart';

class Users extends Table with Auditable {
  TextColumn get username => text().unique()();

  /// Hash bcrypt de la contraseña (nunca texto plano).
  TextColumn get password => text()();
}
