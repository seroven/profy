import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../settings/models/app_currency.dart';
import '../models/proforma_document.dart';
import 'pdf_card.dart';
import 'proforma_pdf_context.dart';
import 'proforma_pdf_fonts.dart';
import 'proforma_pdf_theme.dart';
import 'renderers/payment_methods_block_pdf.dart';
import 'renderers/profile_block_pdf.dart';
import 'renderers/table_block_pdf.dart';
import 'renderers/text_block_pdf.dart';

/// Construye el PDF A4 elegante-moderno a partir del contexto de proforma.
class ProformaPdfBuilder {
  Future<Uint8List> build(ProformaPdfContext context) async {
    final fonts = await _loadFonts();
    setPdfIconsFont(fonts.icons);
    // Importante: NO poner Material Icons en fontFallback (rompe el layout).
    final theme = pw.ThemeData.withFont(
      base: fonts.regular,
      bold: fonts.bold,
      italic: fonts.italic,
      boldItalic: fonts.boldItalic,
    );

    final logo = await _loadImage(context.companyLogoPath);
    final blockWidgets = <pw.Widget>[];
    for (final block in context.document.blocks) {
      final parts = await _renderBlock(block, context);
      if (parts.isEmpty) continue;
      blockWidgets.addAll(parts);
      blockWidgets.add(pw.SizedBox(height: 14));
    }

    final doc = pw.Document(theme: theme, title: context.proforma.code);

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.fromLTRB(36, 32, 36, 36),
          theme: theme,
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(color: PdfColors.white),
          ),
        ),
        footer: (pageContext) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 10),
            padding: const pw.EdgeInsets.only(top: 8),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: ProformaPdfTheme.line, width: 0.7),
              ),
            ),
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Página ${pageContext.pageNumber} / ${pageContext.pagesCount}',
                style: ProformaPdfTheme.caption(),
              ),
            ),
          );
        },
        build: (pageContext) {
          return [
            _buildHeader(context, logo),
            pw.SizedBox(height: 16),
            _buildClientBlock(context),
            pw.SizedBox(height: 16),
            if (blockWidgets.isEmpty)
              pdfBlockCard(
                title: 'Documento',
                child: pw.Text(
                  'Documento sin contenido.',
                  style: ProformaPdfTheme.caption(),
                ),
              )
            else
              ...blockWidgets,
          ];
        },
      ),
    );

    return doc.save();
  }

  pw.Widget _buildHeader(ProformaPdfContext context, pw.MemoryImage? logo) {
    final company = (context.companyName ?? '').trim();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Container(
          height: 4,
          decoration: pw.BoxDecoration(
            color: ProformaPdfTheme.accent,
            borderRadius: pw.BorderRadius.circular(2),
          ),
        ),
        pw.SizedBox(height: 14),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null) ...[
              pdfFramed(
                width: 56,
                height: 56,
                child: pw.SizedBox(
                  width: 56,
                  height: 56,
                  child: pw.Image(logo, fit: pw.BoxFit.cover),
                ),
              ),
              pw.SizedBox(width: 12),
            ] else ...[
              pdfPlaceholderBox(icon: PdfDrawnIcon.business),
              pw.SizedBox(width: 12),
            ],
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    company.isEmpty ? 'Proforma' : company,
                    style: ProformaPdfTheme.title(),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    'DOCUMENTO DE PROFORMA',
                    style: ProformaPdfTheme.label(),
                  ),
                ],
              ),
            ),
            pw.Text(
              pdfFormatDate(context.proforma.proformaDate),
              style: ProformaPdfTheme.caption(),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildClientBlock(ProformaPdfContext context) {
    final client = context.proforma.clientName.trim().isEmpty
        ? '—'
        : context.proforma.clientName.trim();
    final project = context.proforma.projectName.trim().isEmpty
        ? '—'
        : context.proforma.projectName.trim();
    final phone = (context.proforma.phone ?? '').trim();

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(child: _metaColumn('CLIENTE', client)),
        pw.SizedBox(width: 12),
        pw.Expanded(child: _metaColumn('PROYECTO', project)),
        if (phone.isNotEmpty) ...[
          pw.SizedBox(width: 12),
          pw.Expanded(child: _metaColumn('TELÉFONO', phone)),
        ],
      ],
    );
  }

  pw.Widget _metaColumn(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label, style: ProformaPdfTheme.label()),
        pw.SizedBox(height: 3),
        pw.Text(value, style: ProformaPdfTheme.body()),
      ],
    );
  }

  Future<List<pw.Widget>> _renderBlock(
    ProformaBlock block,
    ProformaPdfContext context,
  ) async {
    return switch (block) {
      final ProformaTableBlock table => buildTableBlockPdf(
            table,
            moneyPrefix:
                AppCurrency.fromCode(context.proforma.currency).prefix,
          ),
      final ProformaTextBlock text => await buildTextBlockPdf(text),
      final ProformaProfileBlock _ => [
          await buildProfileBlockPdf(context.profile),
        ],
      final ProformaPaymentMethodsBlock _ => [
          buildPaymentMethodsBlockPdf(context.paymentMethods),
        ],
    };
  }

  Future<_PdfFonts> _loadFonts() async {
    final regular =
        pw.Font.ttf(await rootBundle.load(ProformaPdfFonts.regular));
    final bold = pw.Font.ttf(await rootBundle.load(ProformaPdfFonts.bold));
    final italic =
        pw.Font.ttf(await rootBundle.load(ProformaPdfFonts.italic));
    final boldItalic =
        pw.Font.ttf(await rootBundle.load(ProformaPdfFonts.boldItalic));
    final icons =
        pw.Font.ttf(await rootBundle.load(ProformaPdfFonts.materialIcons));
    return _PdfFonts(
      regular: regular,
      bold: bold,
      italic: italic,
      boldItalic: boldItalic,
      icons: icons,
    );
  }

  Future<pw.MemoryImage?> _loadImage(String? path) async {
    if (path == null || path.trim().isEmpty) return null;
    try {
      final file = File(path);
      if (!await file.exists()) return null;
      return pw.MemoryImage(await file.readAsBytes());
    } catch (_) {
      return null;
    }
  }
}

class _PdfFonts {
  const _PdfFonts({
    required this.regular,
    required this.bold,
    required this.italic,
    required this.boldItalic,
    required this.icons,
  });

  final pw.Font regular;
  final pw.Font bold;
  final pw.Font italic;
  final pw.Font boldItalic;
  final pw.Font icons;
}
