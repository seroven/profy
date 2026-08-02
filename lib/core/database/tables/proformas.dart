import 'package:drift/drift.dart';

import 'table_mixins.dart';
import 'users.dart';

/// Cabecera + documento de proforma (cuerpo en JSON para jerarquía flexible).
class Proformas extends Table with Auditable {
  IntColumn get userId => integer().named('user_id').references(Users, #id)();

  /// Ej: PR-2026-928321
  TextColumn get code => text().unique()();

  TextColumn get clientName =>
      text().named('client_name').withDefault(const Constant(''))();

  TextColumn get projectName =>
      text().named('project_name').withDefault(const Constant(''))();

  TextColumn get phone => text().nullable()();

  DateTimeColumn get proformaDate => dateTime().named('proforma_date')();

  /// `PEN` | `USD` | `EUR`
  TextColumn get currency =>
      text().withDefault(const Constant('PEN'))();

  /// `draft` | `finished`
  TextColumn get status =>
      text().withDefault(const Constant('draft'))();

  /// Bloques del documento (tablas, texto, perfil, medios de pago, …).
  TextColumn get documentJson => text()
      .named('document_json')
      .withDefault(const Constant('{"blocks":[]}'))();
}
