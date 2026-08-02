import 'package:drift/drift.dart';

import 'table_mixins.dart';
import 'user_details.dart';

class UserPreferences extends Table with Auditable {
  IntColumn get userDetailId =>
      integer().named('user_detail_id').unique().references(UserDetails, #id)();

  /// `light` | `dark`
  TextColumn get themeMode =>
      text().named('theme_mode').withDefault(const Constant('dark'))();

  TextColumn get colorTheme =>
      text().named('color_theme').withDefault(const Constant('blue'))();

  /// `PEN` | `USD` | `EUR`
  TextColumn get defaultCurrency =>
      text().named('default_currency').withDefault(const Constant('PEN'))();

  /// `m2` | `m3` | `ft` | `cm`
  TextColumn get defaultUnit =>
      text().named('default_unit').withDefault(const Constant('m2'))();

  TextColumn get companyName => text().named('company_name').nullable()();

  TextColumn get companyLogoPath =>
      text().named('company_logo_path').nullable()();
}
