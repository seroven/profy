import 'dart:io';

import '../../settings/services/local_image_storage.dart';
import '../models/proforma_document.dart';
import '../models/proforma_ids.dart';

/// Clona un [ProformaDocument] regenerando IDs y copiando imágenes a [imageFolder].
class ProformaDocumentCloner {
  ProformaDocumentCloner(this.imageStorage);

  final LocalImageStorage imageStorage;

  Future<ProformaDocument> clone(
    ProformaDocument source, {
    required String imageFolder,
  }) async {
    final idMap = <String, String>{};
    final blocks = <ProformaBlock>[];
    for (final block in source.blocks) {
      blocks.add(await _cloneBlock(block, idMap, imageFolder));
    }
    return ProformaDocument(blocks: blocks);
  }

  Future<ProformaBlock> _cloneBlock(
    ProformaBlock block,
    Map<String, String> idMap,
    String imageFolder,
  ) async {
    return switch (block) {
      ProformaTableBlock table => _cloneTable(table, idMap),
      ProformaTextBlock text => await _cloneText(text, imageFolder),
      ProformaProfileBlock _ => ProformaProfileBlock(
          id: _mapId(idMap, block.id, 'profile'),
        ),
      ProformaPaymentMethodsBlock _ => ProformaPaymentMethodsBlock(
          id: _mapId(idMap, block.id, 'pay'),
        ),
    };
  }

  ProformaTableBlock _cloneTable(
    ProformaTableBlock table,
    Map<String, String> idMap,
  ) {
    final newId = _mapId(idMap, table.id, 'table');
    return ProformaTableBlock(
      id: newId,
      name: table.name,
      sections: [
        for (final section in table.sections) _cloneSection(section, idMap),
      ],
      rows: [
        for (final row in table.rows) _cloneRow(row, idMap),
      ],
    );
  }

  ProformaSection _cloneSection(
    ProformaSection section,
    Map<String, String> idMap,
  ) {
    final newId = _mapId(idMap, section.id, 'sec');
    return ProformaSection(
      id: newId,
      description: section.description,
      subsections: [
        for (final sub in section.subsections) _cloneSubsection(sub, idMap),
      ],
      rows: [
        for (final row in section.rows) _cloneRow(row, idMap),
      ],
    );
  }

  ProformaSubsection _cloneSubsection(
    ProformaSubsection subsection,
    Map<String, String> idMap,
  ) {
    final newId = _mapId(idMap, subsection.id, 'sub');
    return ProformaSubsection(
      id: newId,
      description: subsection.description,
      rows: [
        for (final row in subsection.rows) _cloneRow(row, idMap),
      ],
    );
  }

  ProformaTableRow _cloneRow(
    ProformaTableRow row,
    Map<String, String> idMap,
  ) {
    return switch (row) {
      ProformaItemRow item => ProformaItemRow(
          id: _mapId(idMap, item.id, 'item'),
          description: item.description,
          quantity: item.quantity,
          unit: item.unit,
          unitPrice: item.unitPrice,
        ),
      ProformaSumRow sum => ProformaSumRow(
          id: _mapId(idMap, sum.id, 'sum'),
          targetId: idMap[sum.targetId] ?? sum.targetId,
          target: sum.target,
          label: sum.label,
        ),
      ProformaDiscountRow discount => ProformaDiscountRow(
          id: _mapId(idMap, discount.id, 'disc'),
          amount: discount.amount,
          label: discount.label,
        ),
    };
  }

  Future<ProformaTextBlock> _cloneText(
    ProformaTextBlock text,
    String imageFolder,
  ) async {
    final newId = ProformaIds.next('text');
    final images = <String>[];
    for (final path in text.imagePaths) {
      final copied = await _copyImage(path, imageFolder);
      if (copied != null) images.add(copied);
    }
    return ProformaTextBlock(
      id: newId,
      emoji: text.emoji,
      title: text.title,
      content: text.content,
      imagePaths: images,
    );
  }

  Future<String?> _copyImage(String path, String folder) async {
    final trimmed = path.trim();
    if (trimmed.isEmpty) return null;
    final file = File(trimmed);
    if (!await file.exists()) return null;
    return imageStorage.saveImage(
      source: file,
      folder: folder,
      fileName:
          'doc_${DateTime.now().microsecondsSinceEpoch}_${ProformaIds.next('img')}',
    );
  }

  String _mapId(Map<String, String> idMap, String oldId, String prefix) {
    final existing = idMap[oldId];
    if (existing != null) return existing;
    final next = ProformaIds.next(prefix);
    idMap[oldId] = next;
    return next;
  }
}
