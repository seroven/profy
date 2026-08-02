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

/// Bloque tabla con grid completo, zebra y filas especiales.
pw.Widget buildTableBlockPdf(ProformaTableBlock table) {
  final title = table.name.trim().isEmpty ? 'Tabla' : table.name.trim();

  return pdfBlockCard(
    title: title,
    icon: PdfDrawnIcon.table,
    child: table.sections.isEmpty
        ? pw.Text('Sin secciones.', style: ProformaPdfTheme.caption())
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < table.sections.length; i++) ...[
                _sectionBox(table.sections[i]),
                if (i < table.sections.length - 1) pw.SizedBox(height: 12),
              ],
            ],
          ),
  );
}

pw.Widget _sectionBox(ProformaSection section) {
  final sectionTitle = section.description.trim().isEmpty
      ? 'Sección'
      : section.description.trim();

  final body = <pw.Widget>[
    _fullBanner(sectionTitle, ProformaPdfTheme.sectionBg),
  ];

  if (section.usesSubsections) {
    for (final sub in section.subsections) {
      final subTitle = sub.description.trim().isEmpty
          ? 'Subsección'
          : sub.description.trim();
      body.add(
        _fullBanner(subTitle, ProformaPdfTheme.subsectionBg),
      );
      body.add(
        _dataGrid(
          items: sub.rows.whereType<ProformaItemRow>().toList(),
          finance: _financeRows(
            rows: sub.rows,
            section: section,
            subsection: sub,
          ),
        ),
      );
    }
    final sectionFinance = _financeRows(rows: section.rows, section: section);
    if (sectionFinance.isNotEmpty) {
      body.add(_financeOnlyGrid(sectionFinance));
    }
  } else {
    body.add(
      _dataGrid(
        items: section.rows.whereType<ProformaItemRow>().toList(),
        finance: _financeRows(rows: section.rows, section: section),
      ),
    );
  }

  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.8),
      borderRadius: pw.BorderRadius.circular(6),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: body,
    ),
  );
}

pw.Widget _fullBanner(String text, PdfColor background) {
  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: pw.BoxDecoration(
      color: background,
      border: const pw.Border(
        bottom: pw.BorderSide(color: ProformaPdfTheme.line, width: 0.65),
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
}) {
  final rows = <pw.TableRow>[
    _columnHeaderRow(),
    ..._itemRows(items),
    ...finance,
  ];

  return pw.Table(
    border: pw.TableBorder.all(
      color: ProformaPdfTheme.line,
      width: 0.7,
    ),
    columnWidths: _colWidths,
    defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
    children: rows,
  );
}

pw.Widget _financeOnlyGrid(List<pw.TableRow> finance) {
  return pw.Table(
    border: pw.TableBorder.all(
      color: ProformaPdfTheme.line,
      width: 0.7,
    ),
    columnWidths: _colWidths,
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

List<pw.TableRow> _itemRows(List<ProformaItemRow> items) {
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
            pdfFormatMoney(items[i].unitPrice),
            align: pw.TextAlign.right,
          ),
          _cell(
            pdfFormatMoney(items[i].total),
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
  required ProformaSection section,
  ProformaSubsection? subsection,
}) {
  final result = <pw.TableRow>[];
  for (final row in rows) {
    if (row is ProformaSumRow) {
      final value = ProformaTotals.sumValue(
        sum: row,
        section: section,
        subsection: subsection,
        rows: rows,
      );
      final label = row.label.trim().isEmpty ? 'Suma' : row.label.trim();
      result.add(
        _financeTableRow(
          label: label,
          amount: pdfFormatMoney(value),
          background: ProformaPdfTheme.sumBg,
          emphasize: true,
        ),
      );
    } else if (row is ProformaDiscountRow) {
      final label =
          row.label.trim().isEmpty ? 'Descuento' : row.label.trim();
      result.add(
        _financeTableRow(
          label: label,
          amount: '-${pdfFormatMoney(row.amount)}',
          background: ProformaPdfTheme.discountBg,
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
