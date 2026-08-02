import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import '../models/payment_method_type.dart';
import 'profile_bootstrap_service.dart';

class PaymentMethodsService {
  PaymentMethodsService({
    required this.database,
    required this.bootstrapService,
  });

  final AppDatabase database;
  final ProfileBootstrapService bootstrapService;

  Future<List<PaymentMethod>> listForUser(int userId) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      return (database.select(database.paymentMethods)
            ..where(
              (t) =>
                  t.userDetailId.equals(ensured.detail.id) &
                  t.enable.equals(true),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();
    });
  }

  Future<PaymentMethod> create({
    required int userId,
    required PaymentMethodType type,
    required String name,
    String? phone,
    String? accountNumber,
    String? interbankNumber,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      final count = await (database.select(database.paymentMethods)
            ..where((t) => t.userDetailId.equals(ensured.detail.id)))
          .get();

      final id = await database.into(database.paymentMethods).insert(
            PaymentMethodsCompanion.insert(
              userDetailId: ensured.detail.id,
              type: type.code,
              name: name.trim(),
              phone: Value(_emptyToNull(phone)),
              accountNumber: Value(_emptyToNull(accountNumber)),
              interbankNumber: Value(_emptyToNull(interbankNumber)),
              sortOrder: Value(count.length),
              userCreate: const Value(null),
              userUpdate: const Value(null),
            ),
          );

      return (database.select(database.paymentMethods)
            ..where((t) => t.id.equals(id)))
          .getSingle();
    });
  }

  Future<PaymentMethod> update({
    required int id,
    required PaymentMethodType type,
    required String name,
    String? phone,
    String? accountNumber,
    String? interbankNumber,
  }) {
    return withMinDuration(() async {
      await (database.update(database.paymentMethods)
            ..where((t) => t.id.equals(id)))
          .write(
        PaymentMethodsCompanion(
          type: Value(type.code),
          name: Value(name.trim()),
          phone: Value(_emptyToNull(phone)),
          accountNumber: Value(_emptyToNull(accountNumber)),
          interbankNumber: Value(_emptyToNull(interbankNumber)),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return (database.select(database.paymentMethods)
            ..where((t) => t.id.equals(id)))
          .getSingle();
    });
  }

  Future<void> softDelete(int id) {
    return withMinDuration(() async {
      await (database.update(database.paymentMethods)
            ..where((t) => t.id.equals(id)))
          .write(
        PaymentMethodsCompanion(
          enable: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<PaymentMethod?> getById(int id) {
    return withMinDuration(() async {
      return (database.select(database.paymentMethods)
            ..where((t) => t.id.equals(id) & t.enable.equals(true)))
          .getSingleOrNull();
    });
  }

  String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }
}
