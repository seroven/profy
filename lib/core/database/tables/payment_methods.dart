import 'package:drift/drift.dart';

import 'table_mixins.dart';
import 'user_details.dart';

class PaymentMethods extends Table with Auditable {
  IntColumn get userDetailId =>
      integer().named('user_detail_id').references(UserDetails, #id)();

  /// `yape` | `plin` | `bank_account`
  TextColumn get type => text()();

  TextColumn get name => text()();

  TextColumn get phone => text().nullable()();

  TextColumn get accountNumber => text().named('account_number').nullable()();

  TextColumn get interbankNumber =>
      text().named('interbank_number').nullable()();

  IntColumn get sortOrder =>
      integer().named('sort_order').withDefault(const Constant(0))();
}
