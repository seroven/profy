import 'package:drift/drift.dart';

/// Columnas comunes a todas las tablas del sistema.
mixin Auditable on Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get enable => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();

  TextColumn get userCreate => text().named('user_create').nullable()();

  TextColumn get userUpdate => text().named('user_update').nullable()();
}
