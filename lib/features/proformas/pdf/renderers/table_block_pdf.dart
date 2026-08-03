import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/proforma_document.dart';
import '../../models/proforma_totals.dart';
import '../pdf_card.dart';
import '../proforma_pdf_theme.dart';

const _colWidths = {
  0: pw.FlexColumnWidth(3.2),
  1: pw.FlexColumnWidth(0.9),
  2: pw.FlexColumnWidth(0.8),
  3: pw.FlexColumnWidth(1.1),
  4: pw.FlexColumnWidth(1.1),
};

const double _sectionGap = 16;
const double _subsectionGap = 10;
const double _sectionFinanceGap = 10;

/// Borde completo de grilla (exterior + interior).
final _gridBorder = pw.TableBorder(
  left: const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
  top: const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
  right: const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
  bottom: const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
  horizontalInside:
      const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
  verticalInside:
      const pw.BorderSide(color: ProformaPdfTheme.tableLine, width: 0.85),
);

enum _FinanceTone { nested, section, table }

/// Bloque tabla como un solo widget: sin cortes artificiales ni contorno exterior.
/// Conserva espaciado y sombreado para distinguir sección / subsección / tabla.
List<pw.Widget> buildTableBlockPdf(
  ProformaTableBlock table, {
  required String moneyPrefix,
}) {
  final title = table.name.trim().isEmpty ? 'Tabla' : table.name.trim();
  final tableFinance = _financeRows(
    rows: table.rows,
    sections: table.sections,
    moneyPrefix: moneyPrefix,
    tone: _FinanceTone.table,
  );

  if (table.sections.isEmpty && tableFinance.isEmpty) {
    return [
      pdfBlockCard(
        title: title,
        icon: PdfDrawnIcon.table,
        child: pw.Text('Sin secciones.', style: ProformaPdfTheme.caption()),
      ),
    ];
  }

  final body = <pw.Widget>[];
  for (var i = 0; i < table.sections.length; i++) {
    if (i > 0) body.add(pw.SizedBox(height: _sectionGap));
    body.addAll(_sectionContent(table.sections[i], moneyPrefix: moneyPrefix));
  }
  if (tableFinance.isNotEmpty) {
    if (table.sections.isNotEmpty) body.add(pw.SizedBox(height: _sectionGap));
    body.add(_financeOnlyGrid(tableFinance));
  }

  return [
    pdfBlockCard(
      title: title,
      icon: PdfDrawnIcon.table,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: body,
      ),
    ),
  ];
}

List<pw.Widget> _sectionContent(
  ProformaSection section, {
  required String moneyPrefix,
}) {
  final sectionTitle = section.description.trim().isEmpty
      ? 'Sección'
      : section.description.trim();

  final out = <pw.Widget>[
    _fullBanner(sectionTitle, ProformaPdfTheme.sectionBg),
  ];

  if (section.usesSubsections) {
    for (var i = 0; i < section.subsections.length; i++) {
      final sub = section.subsections[i];
      final subTitle = sub.description.trim().isEmpty
          ? 'Subsección'
          : sub.description.trim();

      if (i > 0) out.add(pw.SizedBox(height: _subsectionGap));
      out.add(_fullBanner(subTitle, ProformaPdfTheme.subsectionBg));
      out.add(
        _dataGrid(
          items: sub.rows.whereType<ProformaItemRow>().toList(),
          finance: _financeRows(
            rows: sub.rows,
            section: section,
            subsection: sub,
            moneyPrefix: moneyPrefix,
            tone: _FinanceTone.nested,
          ),
          moneyPrefix: moneyPrefix,
        ),
      );
    }

    final sectionFinance = _financeRows(
      rows: section.rows,
      section: section,
      moneyPrefix: moneyPrefix,
      tone: _FinanceTone.section,
    );
    if (sectionFinance.isNotEmpty) {
      out.add(pw.SizedBox(height: _sectionFinanceGap));
      out.add(_financeOnlyGrid(sectionFinance));
    }
  } else {
    out.add(
      _dataGrid(
        items: section.rows.whereType<ProformaItemRow>().toList(),
        finance: _financeRows(
          rows: section.rows,
          section: section,
          moneyPrefix: moneyPrefix,
          tone: _FinanceTone.section,
        ),
        moneyPrefix: moneyPrefix,
      ),
    );
  }

  return out;
}

pw.Widget _fullBanner(String text, PdfColor background) {
  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: pw.BoxDecoration(
      color: background,
      border: pw.Border.all(
        color: ProformaPdfTheme.tableLine,
        width: 0.85,
      ),
    ),
    child: pw.Text(
      text,
      style: ProformaPdfTheme.body().copyWith(
        fontWeight: pw.FontWeight.bold,
        fontSize: 9.5,
      ),
    ),
  );
}

pw.Widget _dataGrid({
  required List<ProformaItemRow> items,
  required List<pw.TableRow> finance,
  required String moneyPrefix,
}) {
  final rows = <pw.TableRow>[
    _columnHeaderRow(),
    ..._itemRows(items, moneyPrefix: moneyPrefix),
    ...finance,
  ];

  return pw.Table(
    border: _gridBorder,
    columnWidths: _colWidths,
    defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
    children: rows,
  );
}

pw.Widget _financeOnlyGrid(List<pw.TableRow> finance) {
  return pw.Table(
    border: _gridBorder,
    columnWidths: _colWidths,
    defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
    children: finance,
  );
}

pw.TableRow _columnHeaderRow() {
  return pw.TableRow(
    decoration: const pw.BoxDecoration(color: ProformaPdfTheme.accent),
    children: [
      _cell('Descripción', style: ProformaPdfTheme.tableHeader()),
      _cell(
        'Cant.',
        style: ProformaPdfTheme.tableHeader(),
        align: pw.TextAlign.right,
      ),
      _cell(
        'Ud.',
        style: ProformaPdfTheme.tableHeader(),
        align: pw.TextAlign.center,
      ),
      _cell(
        'P. unit.',
        style: ProformaPdfTheme.tableHeader(),
        align: pw.TextAlign.right,
      ),
      _cell(
        'Total',
        style: ProformaPdfTheme.tableHeader(),
        align: pw.TextAlign.right,
      ),
    ],
  );
}

List<pw.TableRow> _itemRows(
  List<ProformaItemRow> items, {
  required String moneyPrefix,
}) {
  if (items.isEmpty) {
    return [
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: ProformaPdfTheme.white),
        children: [
          _cell('Sin ítems.', style: ProformaPdfTheme.caption()),
          _cell(''),
          _cell(''),
          _cell(''),
          _cell(''),
        ],
      ),
    ];
  }

  return [
    for (var i = 0; i < items.length; i++)
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: ProformaPdfTheme.white),
        children: [
          _cell(
            items[i].description.trim().isEmpty
                ? '—'
                : items[i].description.trim(),
          ),
          _cell(
            pdfStripZeros(items[i].quantity),
            align: pw.TextAlign.right,
          ),
          _cell(items[i].unit, align: pw.TextAlign.center),
          _cell(
            pdfFormatMoney(items[i].unitPrice, prefix: moneyPrefix),
            align: pw.TextAlign.right,
          ),
          _cell(
            pdfFormatMoney(items[i].total, prefix: moneyPrefix),
            align: pw.TextAlign.right,
            style: ProformaPdfTheme.tableCell().copyWith(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
  ];
}

List<pw.TableRow> _financeRows({
  required List<ProformaTableRow> rows,
  required String moneyPrefix,
  required _FinanceTone tone,
  ProformaSection? section,
  ProformaSubsection? subsection,
  List<ProformaSection>? sections,
}) {
  final sumBg = switch (tone) {
    _FinanceTone.section => ProformaPdfTheme.sectionSumBg,
    _FinanceTone.nested || _FinanceTone.table => ProformaPdfTheme.sumBg,
  };
  final discountBg = switch (tone) {
    _FinanceTone.section => ProformaPdfTheme.sectionDiscountBg,
    _FinanceTone.nested || _FinanceTone.table => ProformaPdfTheme.discountBg,
  };

  final result = <pw.TableRow>[];
  for (final row in rows) {
    if (row is ProformaSumRow) {
      final value = ProformaTotals.sumValue(
        sum: row,
        section: section,
        subsection: subsection,
        sections: sections,
        rows: rows,
      );
      final label = row.label.trim().isEmpty ? 'Suma' : row.label.trim();
      result.add(
        _financeTableRow(
          label: label,
          amount: pdfFormatMoney(value, prefix: moneyPrefix),
          background: sumBg,
          emphasize: true,
        ),
      );
    } else if (row is ProformaDiscountRow) {
      final label =
          row.label.trim().isEmpty ? 'Descuento' : row.label.trim();
      result.add(
        _financeTableRow(
          label: label,
          amount: '-${pdfFormatMoney(row.amount, prefix: moneyPrefix)}',
          background: discountBg,
          emphasize: false,
        ),
      );
    }
  }
  return result;
}

pw.TableRow _financeTableRow({
  required String label,
  required String amount,
  required PdfColor background,
  required bool emphasize,
}) {
  final style = ProformaPdfTheme.body().copyWith(
    fontWeight: emphasize ? pw.FontWeight.bold : pw.FontWeight.normal,
    fontSize: 9.5,
  );
  return pw.TableRow(
    decoration: pw.BoxDecoration(color: background),
    children: [
      _cell(label, style: style),
      _cell('', background: background),
      _cell('', background: background),
      _cell('', background: background),
      _cell(amount, style: style, align: pw.TextAlign.right),
    ],
  );
}

pw.Widget _cell(
  String text, {
  pw.TextStyle? style,
  pw.TextAlign align = pw.TextAlign.left,
  PdfColor? background,
}) {
  final child = pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 7),
    child: pw.Text(
      text,
      textAlign: align,
      style: style ?? ProformaPdfTheme.tableCell(),
    ),
  );
  if (background == null) return child;
  return pw.Container(color: background, child: child);
}
