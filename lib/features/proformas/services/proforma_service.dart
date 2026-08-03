import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import '../../settings/models/app_currency.dart';
import '../models/proforma_document.dart';
import '../models/proforma_status.dart';
import 'proforma_code_generator.dart';

class ProformaService {
  ProformaService(this.database);

  final AppDatabase database;

  Future<List<Proforma>> listForUser(int userId) {
    return withMinDuration(() async {
      return (database.select(database.proformas)
            ..where((t) => t.userId.equals(userId) & t.enable.equals(true))
            ..orderBy([
              (t) => OrderingTerm(
                    expression: t.updatedAt,
                    mode: OrderingMode.desc,
                  ),
            ]))
          .get();
    });
  }

  /// Lectura rápida para el editor (sin delay percibido).
  Future<Proforma?> getById(int id) {
    return (database.select(database.proformas)
          ..where((t) => t.id.equals(id) & t.enable.equals(true)))
        .getSingleOrNull();
  }

  Future<Proforma> createDraft({
    required int userId,
    AppCurrency? currency,
    ProformaDocument? document,
  }) {
    return withMinDuration(() async {
      final code = await _uniqueCode();
      final now = DateTime.now();
      final id = await database.into(database.proformas).insert(
            ProformasCompanion.insert(
              userId: userId,
              code: code,
              proformaDate: DateTime(now.year, now.month, now.day),
              currency: Value(currency?.code ?? AppCurrency.pen.code),
              status: Value(ProformaStatus.draft.code),
              documentJson: Value(
                (document ?? ProformaDocument.empty()).toJsonString(),
              ),
              userCreate: const Value(null),
              userUpdate: const Value(null),
            ),
          );
      return (database.select(database.proformas)
            ..where((t) => t.id.equals(id)))
          .getSingle();
    });
  }

  /// Autosave completo (cabecera + documento) sin delay artificial.
  Future<Proforma> saveEditorState({
    required int id,
    required String clientName,
    required String projectName,
    required String? phone,
    required DateTime proformaDate,
    required AppCurrency currency,
    required ProformaDocument document,
  }) async {
    final trimmedPhone = phone?.trim();
    await (database.update(database.proformas)..where((t) => t.id.equals(id)))
        .write(
      ProformasCompanion(
        clientName: Value(clientName.trim()),
        projectName: Value(projectName.trim()),
        phone: Value(
          trimmedPhone == null || trimmedPhone.isEmpty ? null : trimmedPhone,
        ),
        proformaDate: Value(
          DateTime(proformaDate.year, proformaDate.month, proformaDate.day),
        ),
        currency: Value(currency.code),
        documentJson: Value(document.toJsonString()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return (await getById(id))!;
  }

  Future<Proforma> markFinished(int id) async {
    await (database.update(database.proformas)..where((t) => t.id.equals(id)))
        .write(
      ProformasCompanion(
        status: Value(ProformaStatus.finished.code),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return (await getById(id))!;
  }

  Future<Proforma> markDraft(int id) async {
    await (database.update(database.proformas)..where((t) => t.id.equals(id)))
        .write(
      ProformasCompanion(
        status: Value(ProformaStatus.draft.code),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> softDelete(int id) {
    return withMinDuration(() async {
      await (database.update(database.proformas)
            ..where((t) => t.id.equals(id)))
          .write(
        ProformasCompanion(
          enable: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<String> _uniqueCode() async {
    for (var attempt = 0; attempt < 12; attempt++) {
      final code = ProformaCodeGenerator.generate();
      final existing = await (database.select(database.proformas)
            ..where((t) => t.code.equals(code)))
          .getSingleOrNull();
      if (existing == null) return code;
    }
    return '${ProformaCodeGenerator.generate()}${DateTime.now().millisecond}';
  }
}
