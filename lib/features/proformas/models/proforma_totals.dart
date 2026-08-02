import 'proforma_document.dart';

/// Cálculos de sumas / descuentos sobre el árbol de la tabla.
abstract final class ProformaTotals {
  static double itemsTotal(Iterable<ProformaTableRow> rows) {
    return rows.whereType<ProformaItemRow>().fold<double>(
          0,
          (sum, item) => sum + item.total,
        );
  }

  static double discountsTotal(Iterable<ProformaTableRow> rows) {
    return rows.whereType<ProformaDiscountRow>().fold<double>(
          0,
          (sum, item) => sum + item.amount,
        );
  }

  /// Suma de ítems de una subsección (sin descontar aún).
  static double subsectionItemsTotal(ProformaSubsection subsection) {
    return itemsTotal(subsection.rows);
  }

  /// Total de subsección tras su cadena suma/descuento (si existe).
  static double subsectionRollupTotal({
    required ProformaSection section,
    required ProformaSubsection subsection,
  }) {
    final lastSum = subsection.rows.whereType<ProformaSumRow>().lastOrNull;
    if (lastSum != null) {
      final value = sumValue(
        sum: lastSum,
        section: section,
        subsection: subsection,
        rows: subsection.rows,
      );
      return chainNet(
        rows: subsection.rows,
        sum: lastSum,
        sumAmount: value,
      );
    }
    return itemsTotal(subsection.rows);
  }

  /// Total de sección listo para rollup a tabla (incluye su cadena finance).
  static double sectionRollupTotal(ProformaSection section) {
    final lastSum = section.rows.whereType<ProformaSumRow>().lastOrNull;
    if (lastSum != null) {
      final value = sumValue(
        sum: lastSum,
        section: section,
        rows: section.rows,
      );
      return chainNet(
        rows: section.rows,
        sum: lastSum,
        sumAmount: value,
      );
    }

    if (section.usesSubsections) {
      return section.subsections.fold<double>(
        0,
        (sum, sub) =>
            sum +
            subsectionRollupTotal(section: section, subsection: sub),
      );
    }

    return itemsTotal(section.rows);
  }

  /// Valor de una fila "Suma" según su destino.
  static double sumValue({
    required ProformaSumRow sum,
    required List<ProformaTableRow> rows,
    ProformaSection? section,
    ProformaSubsection? subsection,
    List<ProformaSection>? sections,
  }) {
    if (sum.target == ProformaSumTarget.chain) {
      final previous = _previousSum(rows, sum.id);
      if (previous == null) return 0;
      final previousAmount = sumValue(
        sum: previous,
        section: section,
        subsection: subsection,
        sections: sections,
        rows: rows,
      );
      return chainNet(
        rows: rows,
        sum: previous,
        sumAmount: previousAmount,
        untilRowId: sum.id,
      );
    }

    if (sum.target == ProformaSumTarget.table) {
      final list = sections ?? const <ProformaSection>[];
      return list.fold<double>(0, (acc, s) => acc + sectionRollupTotal(s));
    }

    final scopedSection = section;
    if (scopedSection == null) return 0;

    if (sum.target == ProformaSumTarget.subsection) {
      final target =
          subsection ?? _findSubsection(scopedSection, sum.targetId);
      if (target == null) return 0;
      return subsectionItemsTotal(target);
    }

    // Sección: si tiene subsecciones → ítems − descuentos internos.
    if (scopedSection.usesSubsections) {
      var items = 0.0;
      var discounts = 0.0;
      for (final sub in scopedSection.subsections) {
        items += itemsTotal(sub.rows);
        discounts += discountsTotal(sub.rows);
      }
      return items - discounts;
    }

    return itemsTotal(scopedSection.rows);
  }

  /// Total neto tras la suma y los descuentos que la siguen.
  static double chainNet({
    required List<ProformaTableRow> rows,
    required ProformaSumRow sum,
    required double sumAmount,
    String? untilRowId,
  }) {
    var total = sumAmount;
    var passedSum = false;
    for (final row in rows) {
      if (untilRowId != null && row.id == untilRowId) break;
      if (row.id == sum.id) {
        passedSum = true;
        continue;
      }
      if (!passedSum) continue;
      if (row is ProformaSumRow) break;
      if (row is ProformaDiscountRow) {
        total -= row.amount;
      }
    }
    return total;
  }

  /// Primera suma: si no hay ninguna.
  /// Suma neta: solo justo después de un descuento.
  static bool canAddSum(List<ProformaTableRow> rows) {
    if (!rows.any((row) => row is ProformaSumRow)) return true;

    for (var i = rows.length - 1; i >= 0; i--) {
      final row = rows[i];
      if (row is ProformaDiscountRow) return true;
      if (row is ProformaSumRow || row is ProformaItemRow) return false;
    }
    return false;
  }

  static bool canAddDiscount(List<ProformaTableRow> rows) {
    for (var i = rows.length - 1; i >= 0; i--) {
      final row = rows[i];
      if (row is ProformaSumRow || row is ProformaDiscountRow) return true;
      if (row is ProformaItemRow) return false;
    }
    return false;
  }

  static bool hasAnySum(List<ProformaTableRow> rows) {
    return rows.any((row) => row is ProformaSumRow);
  }

  /// Hay contenido sumable en alguna sección (ítems o finance interno).
  static bool tableHasSummableScope(List<ProformaSection> sections) {
    for (final section in sections) {
      if (section.rows.any((row) => row is ProformaItemRow)) return true;
      if (hasAnySum(section.rows)) return true;
      for (final sub in section.subsections) {
        if (sub.rows.any((row) => row is ProformaItemRow)) return true;
        if (hasAnySum(sub.rows)) return true;
      }
    }
    return false;
  }

  /// Inserta un ítem antes del bloque suma/descuento.
  static List<ProformaTableRow> insertItem(
    List<ProformaTableRow> rows,
    ProformaItemRow item,
  ) {
    final index = rows.indexWhere(
      (row) => row is ProformaSumRow || row is ProformaDiscountRow,
    );
    if (index < 0) return [...rows, item];
    return [...rows.sublist(0, index), item, ...rows.sublist(index)];
  }

  static ProformaSubsection? _findSubsection(
    ProformaSection section,
    String id,
  ) {
    for (final sub in section.subsections) {
      if (sub.id == id) return sub;
    }
    return null;
  }

  static ProformaSumRow? _previousSum(List<ProformaTableRow> rows, String sumId) {
    final index = rows.indexWhere((row) => row.id == sumId);
    if (index <= 0) return null;
    for (var i = index - 1; i >= 0; i--) {
      final row = rows[i];
      if (row is ProformaSumRow) return row;
    }
    return null;
  }

  /// Quita una fila; si es suma, también los descuentos que la siguen.
  static List<ProformaTableRow> removeRow(
    List<ProformaTableRow> rows,
    String rowId,
  ) {
    final index = rows.indexWhere((row) => row.id == rowId);
    if (index < 0) return rows;
    final target = rows[index];
    if (target is! ProformaSumRow) {
      return rows.where((row) => row.id != rowId).toList();
    }

    final kept = <ProformaTableRow>[...rows.sublist(0, index)];
    var i = index + 1;
    while (i < rows.length && rows[i] is ProformaDiscountRow) {
      i++;
    }
    kept.addAll(rows.sublist(i));
    return kept;
  }
}
