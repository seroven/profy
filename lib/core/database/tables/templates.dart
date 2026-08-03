import 'package:drift/drift.dart';

import 'table_mixins.dart';
import 'users.dart';

/// Plantilla de documento (solo cuerpo JSON; sin cabecera de proforma).
class Templates extends Table with Auditable {
  IntColumn get userId => integer().named('user_id').references(Users, #id)();

  TextColumn get name => text().withDefault(const Constant(''))();

  /// Bloques del documento (mismo esquema que proformas.document_json).
  TextColumn get documentJson => text()
      .named('document_json')
      .withDefault(const Constant('{"blocks":[]}'))();
}
