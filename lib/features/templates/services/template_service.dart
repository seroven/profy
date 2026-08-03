import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import '../../proformas/models/proforma_document.dart';
import '../../proformas/services/proforma_document_cloner.dart';
import '../../settings/services/local_image_storage.dart';

class TemplateService {
  TemplateService({
    required this.database,
    required this.imageStorage,
  });

  final AppDatabase database;
  final LocalImageStorage imageStorage;

  ProformaDocumentCloner get _cloner => ProformaDocumentCloner(imageStorage);

  Future<List<Template>> listForUser(int userId) {
    return withMinDuration(() async {
      return (database.select(database.templates)
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

  Future<Template?> getById(int id) {
    return (database.select(database.templates)
          ..where((t) => t.id.equals(id) & t.enable.equals(true)))
        .getSingleOrNull();
  }

  Future<Template> create({
    required int userId,
    String name = 'Nueva plantilla',
  }) {
    return withMinDuration(() async {
      final trimmed = name.trim();
      final id = await database.into(database.templates).insert(
            TemplatesCompanion.insert(
              userId: userId,
              name: Value(trimmed.isEmpty ? 'Nueva plantilla' : trimmed),
              documentJson: Value(ProformaDocument.empty().toJsonString()),
            ),
          );
      return (database.select(database.templates)..where((t) => t.id.equals(id)))
          .getSingle();
    });
  }

  Future<Template> saveEditorState({
    required int id,
    required String name,
    required ProformaDocument document,
  }) async {
    final trimmed = name.trim();
    await (database.update(database.templates)..where((t) => t.id.equals(id)))
        .write(
      TemplatesCompanion(
        name: Value(trimmed.isEmpty ? 'Sin nombre' : trimmed),
        documentJson: Value(document.toJsonString()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> softDelete(int id) {
    return withMinDuration(() async {
      final previous = await getById(id);
      await (database.update(database.templates)..where((t) => t.id.equals(id)))
          .write(
        TemplatesCompanion(
          enable: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (previous != null) {
        final document =
            ProformaDocument.fromJsonString(previous.documentJson);
        for (final block in document.blocks) {
          if (block is! ProformaTextBlock) continue;
          for (final path in block.imagePaths) {
            await imageStorage.deleteIfExists(path);
          }
        }
      }
    });
  }

  /// Copia el cuerpo de la plantilla con IDs nuevos e imágenes duplicadas.
  Future<ProformaDocument> materializeForProforma(Template template) {
    return _cloner.clone(
      ProformaDocument.fromJsonString(template.documentJson),
      imageFolder: 'proforma_text',
    );
  }
}
