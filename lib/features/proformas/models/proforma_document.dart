import 'dart:convert';

import '../../settings/models/measure_unit.dart';
import 'proforma_ids.dart';

/// Documento de proforma: lista ordenada de bloques (reordenables).
class ProformaDocument {
  const ProformaDocument({this.blocks = const []});

  final List<ProformaBlock> blocks;

  factory ProformaDocument.empty() => const ProformaDocument();

  factory ProformaDocument.fromJsonString(String raw) {
    if (raw.trim().isEmpty) return ProformaDocument.empty();
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return ProformaDocument.empty();
    return ProformaDocument.fromJson(decoded);
  }

  factory ProformaDocument.fromJson(Map<String, dynamic> json) {
    final rawBlocks = json['blocks'];
    if (rawBlocks is! List) return ProformaDocument.empty();
    return ProformaDocument(
      blocks: rawBlocks
          .whereType<Map>()
          .map((item) => ProformaBlock.fromJson(
                Map<String, dynamic>.from(item),
              ))
          .whereType<ProformaBlock>()
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'blocks': blocks.map((block) => block.toJson()).toList(),
      };

  String toJsonString() => jsonEncode(toJson());

  ProformaDocument copyWith({List<ProformaBlock>? blocks}) {
    return ProformaDocument(blocks: blocks ?? this.blocks);
  }

  List<ProformaTableBlock> get tables =>
      blocks.whereType<ProformaTableBlock>().toList();
}

enum ProformaBlockType {
  table,
  text,
  profile,
  paymentMethods;

  static ProformaBlockType? tryParse(String? value) {
    if (value == null) return null;
    for (final item in ProformaBlockType.values) {
      if (item.name == value) return item;
    }
    if (value == 'payment_methods') return ProformaBlockType.paymentMethods;
    return null;
  }
}

sealed class ProformaBlock {
  const ProformaBlock({required this.id});

  final String id;
  ProformaBlockType get type;
  Map<String, dynamic> toJson();

  static ProformaBlock? fromJson(Map<String, dynamic> json) {
    final type = ProformaBlockType.tryParse(json['type'] as String?);
    final id = json['id'] as String? ?? '';
    if (id.isEmpty || type == null) return null;

    return switch (type) {
      ProformaBlockType.table => ProformaTableBlock.fromJson(id, json),
      ProformaBlockType.text => ProformaTextBlock.fromJson(id, json),
      ProformaBlockType.profile => ProformaProfileBlock(id: id),
      ProformaBlockType.paymentMethods => ProformaPaymentMethodsBlock(id: id),
    };
  }
}

class ProformaTableBlock extends ProformaBlock {
  const ProformaTableBlock({
    required super.id,
    this.name = '',
    this.sections = const [],
    this.rows = const [],
  });

  final String name;
  final List<ProformaSection> sections;

  /// Sumas / descuentos a nivel tabla (scope: secciones).
  final List<ProformaTableRow> rows;

  @override
  ProformaBlockType get type => ProformaBlockType.table;

  factory ProformaTableBlock.create() => ProformaTableBlock(
        id: ProformaIds.next('table'),
        name: 'Tabla',
        sections: [ProformaSection.create()],
      );

  factory ProformaTableBlock.fromJson(String id, Map<String, dynamic> json) {
    final raw = json['sections'];
    final rawRows = json['rows'];
    return ProformaTableBlock(
      id: id,
      name: json['name'] as String? ?? '',
      sections: raw is List
          ? raw
              .whereType<Map>()
              .map(
                (item) => ProformaSection.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : const [],
      rows: rawRows is List
          ? rawRows
              .whereType<Map>()
              .map(
                (item) => ProformaTableRow.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .whereType<ProformaTableRow>()
              .toList()
          : const [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'name': name,
        'sections': sections.map((s) => s.toJson()).toList(),
        'rows': rows.map((r) => r.toJson()).toList(),
      };

  ProformaTableBlock copyWith({
    String? name,
    List<ProformaSection>? sections,
    List<ProformaTableRow>? rows,
  }) {
    return ProformaTableBlock(
      id: id,
      name: name ?? this.name,
      sections: sections ?? this.sections,
      rows: rows ?? this.rows,
    );
  }
}

/// Sección: o bien ítems directos, o bien subsecciones (XOR).
class ProformaSection {
  const ProformaSection({
    required this.id,
    this.description = '',
    this.subsections = const [],
    this.rows = const [],
  });

  final String id;
  final String description;
  final List<ProformaSubsection> subsections;
  final List<ProformaTableRow> rows;

  bool get usesSubsections => subsections.isNotEmpty;
  bool get usesItems => rows.any((row) => row is ProformaItemRow);
  bool get isEmpty =>
      subsections.isEmpty && !rows.any((row) => row is ProformaItemRow);

  factory ProformaSection.create() => ProformaSection(
        id: ProformaIds.next('sec'),
      );

  factory ProformaSection.fromJson(Map<String, dynamic> json) {
    final rawSubs = json['subsections'];
    final rawRows = json['rows'];
    return ProformaSection(
      id: json['id'] as String? ?? ProformaIds.next('sec'),
      description: json['description'] as String? ?? '',
      subsections: rawSubs is List
          ? rawSubs
              .whereType<Map>()
              .map(
                (item) => ProformaSubsection.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : const [],
      rows: rawRows is List
          ? rawRows
              .whereType<Map>()
              .map(
                (item) => ProformaTableRow.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .whereType<ProformaTableRow>()
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'subsections': subsections.map((s) => s.toJson()).toList(),
        'rows': rows.map((r) => r.toJson()).toList(),
      };

  ProformaSection copyWith({
    String? description,
    List<ProformaSubsection>? subsections,
    List<ProformaTableRow>? rows,
  }) {
    return ProformaSection(
      id: id,
      description: description ?? this.description,
      subsections: subsections ?? this.subsections,
      rows: rows ?? this.rows,
    );
  }

  /// Mueve ítems directos a una subsección nueva.
  ProformaSection wrapItemsInSubsection({String description = ''}) {
    final items = rows.whereType<ProformaItemRow>().toList();
    if (items.isEmpty) return this;
    final sub = ProformaSubsection(
      id: ProformaIds.next('sub'),
      description: description.isEmpty ? 'Subsección' : description,
      rows: items,
    );
    return copyWith(subsections: [...subsections, sub], rows: const []);
  }
}

class ProformaSubsection {
  const ProformaSubsection({
    required this.id,
    this.description = '',
    this.rows = const [],
  });

  final String id;
  final String description;
  final List<ProformaTableRow> rows;

  factory ProformaSubsection.create() => ProformaSubsection(
        id: ProformaIds.next('sub'),
      );

  factory ProformaSubsection.fromJson(Map<String, dynamic> json) {
    final rawRows = json['rows'];
    return ProformaSubsection(
      id: json['id'] as String? ?? ProformaIds.next('sub'),
      description: json['description'] as String? ?? '',
      rows: rawRows is List
          ? rawRows
              .whereType<Map>()
              .map(
                (item) => ProformaTableRow.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .whereType<ProformaTableRow>()
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'rows': rows.map((r) => r.toJson()).toList(),
      };

  ProformaSubsection copyWith({
    String? description,
    List<ProformaTableRow>? rows,
  }) {
    return ProformaSubsection(
      id: id,
      description: description ?? this.description,
      rows: rows ?? this.rows,
    );
  }
}

sealed class ProformaTableRow {
  const ProformaTableRow({required this.id});

  final String id;

  Map<String, dynamic> toJson();

  static ProformaTableRow? fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? 'item';
    final id = json['id'] as String? ?? ProformaIds.next('row');
    return switch (type) {
      'item' => ProformaItemRow.fromJson(id, json),
      'sum' => ProformaSumRow.fromJson(id, json),
      'discount' => ProformaDiscountRow.fromJson(id, json),
      _ => null,
    };
  }
}

enum ProformaSumTarget {
  table,
  section,
  subsection,
  /// Neto de la cadena anterior (suma + descuentos previos).
  chain;

  static ProformaSumTarget fromCode(String? code) {
    return switch (code) {
      'table' => ProformaSumTarget.table,
      'section' => ProformaSumTarget.section,
      'chain' => ProformaSumTarget.chain,
      _ => ProformaSumTarget.subsection,
    };
  }
}

/// Fila de suma: referencia a la sección/subsección o a la cadena previa.
class ProformaSumRow extends ProformaTableRow {
  const ProformaSumRow({
    required super.id,
    required this.targetId,
    required this.target,
    this.label = 'Suma',
  });

  final String targetId;
  final ProformaSumTarget target;
  final String label;

  factory ProformaSumRow.create({
    required String targetId,
    required ProformaSumTarget target,
    String? label,
  }) =>
      ProformaSumRow(
        id: ProformaIds.next('sum'),
        targetId: targetId,
        target: target,
        label: label ??
            switch (target) {
              ProformaSumTarget.chain => 'Suma neta',
              ProformaSumTarget.table => 'Suma de tabla',
              ProformaSumTarget.section => 'Suma de sección',
              ProformaSumTarget.subsection => 'Suma',
            },
      );

  factory ProformaSumRow.fromJson(String id, Map<String, dynamic> json) {
    return ProformaSumRow(
      id: id,
      targetId: json['targetId'] as String? ??
          json['target_id'] as String? ??
          '',
      target: ProformaSumTarget.fromCode(json['target'] as String?),
      label: json['label'] as String? ?? 'Suma',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': 'sum',
        'targetId': targetId,
        'target': target.name,
        'label': label,
      };

  ProformaSumRow copyWith({String? label}) {
    return ProformaSumRow(
      id: id,
      targetId: targetId,
      target: target,
      label: label ?? this.label,
    );
  }
}

/// Descuento en dinero (si el usuario eligió %, se convierte al guardar).
class ProformaDiscountRow extends ProformaTableRow {
  const ProformaDiscountRow({
    required super.id,
    required this.amount,
    this.label = 'Descuento',
  });

  final double amount;
  final String label;

  factory ProformaDiscountRow.create({required double amount}) =>
      ProformaDiscountRow(
        id: ProformaIds.next('disc'),
        amount: amount,
      );

  factory ProformaDiscountRow.fromJson(String id, Map<String, dynamic> json) {
    return ProformaDiscountRow(
      id: id,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      label: json['label'] as String? ?? 'Descuento',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': 'discount',
        'amount': amount,
        'label': label,
      };

  ProformaDiscountRow copyWith({double? amount, String? label}) {
    return ProformaDiscountRow(
      id: id,
      amount: amount ?? this.amount,
      label: label ?? this.label,
    );
  }
}

class ProformaItemRow extends ProformaTableRow {
  const ProformaItemRow({
    required super.id,
    this.description = '',
    this.quantity = 1,
    this.unit = 'm2',
    this.unitPrice = 0,
  });

  final String description;
  final double quantity;
  final String unit;
  final double unitPrice;

  double get total => quantity * unitPrice;

  MeasureUnit get measureUnit => MeasureUnit.fromCode(unit);

  factory ProformaItemRow.create({String? defaultUnit}) => ProformaItemRow(
        id: ProformaIds.next('item'),
        unit: defaultUnit ?? MeasureUnit.m2.code,
      );

  factory ProformaItemRow.fromJson(String id, Map<String, dynamic> json) {
    return ProformaItemRow(
      id: id,
      description: json['description'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1,
      unit: json['unit'] as String? ?? MeasureUnit.m2.code,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ??
          (json['unit_price'] as num?)?.toDouble() ??
          0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': 'item',
        'description': description,
        'quantity': quantity,
        'unit': unit,
        'unitPrice': unitPrice,
      };

  ProformaItemRow copyWith({
    String? description,
    double? quantity,
    String? unit,
    double? unitPrice,
  }) {
    return ProformaItemRow(
      id: id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}

class ProformaTextBlock extends ProformaBlock {
  const ProformaTextBlock({
    required super.id,
    this.emoji,
    this.title,
    this.content = '',
    this.imagePaths = const [],
  });

  final String? emoji;
  final String? title;
  final String content;
  final List<String> imagePaths;

  @override
  ProformaBlockType get type => ProformaBlockType.text;

  factory ProformaTextBlock.create() => ProformaTextBlock(
        id: ProformaIds.next('text'),
      );

  factory ProformaTextBlock.fromJson(String id, Map<String, dynamic> json) {
    final images = json['imagePaths'] ?? json['image_paths'];
    return ProformaTextBlock(
      id: id,
      emoji: json['emoji'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String? ?? '',
      imagePaths: images is List
          ? images.whereType<String>().toList()
          : const [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'emoji': emoji,
        'title': title,
        'content': content,
        'imagePaths': imagePaths,
      };

  ProformaTextBlock copyWith({
    String? emoji,
    String? title,
    String? content,
    List<String>? imagePaths,
    bool clearEmoji = false,
    bool clearTitle = false,
  }) {
    return ProformaTextBlock(
      id: id,
      emoji: clearEmoji ? null : (emoji ?? this.emoji),
      title: clearTitle ? null : (title ?? this.title),
      content: content ?? this.content,
      imagePaths: imagePaths ?? this.imagePaths,
    );
  }
}

class ProformaProfileBlock extends ProformaBlock {
  const ProformaProfileBlock({required super.id});

  @override
  ProformaBlockType get type => ProformaBlockType.profile;

  factory ProformaProfileBlock.create() => ProformaProfileBlock(
        id: ProformaIds.next('profile'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
      };
}

class ProformaPaymentMethodsBlock extends ProformaBlock {
  const ProformaPaymentMethodsBlock({required super.id});

  @override
  ProformaBlockType get type => ProformaBlockType.paymentMethods;

  factory ProformaPaymentMethodsBlock.create() => ProformaPaymentMethodsBlock(
        id: ProformaIds.next('pay'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
      };
}
