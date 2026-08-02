import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import '../../../../core/database/app_database.dart';
import '../pdf_card.dart';
import '../proforma_pdf_theme.dart';

/// Bloque perfil: nombre destacado + rejilla de 2 columnas para el resto.
Future<pw.Widget> buildProfileBlockPdf(UserDetail? detail) async {
  if (detail == null) {
    return pdfBlockCard(
      title: 'Datos de contacto',
      icon: PdfDrawnIcon.user,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfUserAvatar(size: 56),
          pw.SizedBox(width: 14),
          pw.Expanded(
            child: pw.Text(
              'Sin datos de perfil configurados.',
              style: ProformaPdfTheme.caption(),
            ),
          ),
        ],
      ),
    );
  }

  final name = [
    detail.firstName,
    detail.lastName,
  ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' ');

  final meta = <(String, String)>[
    if ((detail.phone ?? '').trim().isNotEmpty)
      ('TELÉFONO', detail.phone!.trim()),
    if ((detail.email ?? '').trim().isNotEmpty)
      ('EMAIL', detail.email!.trim()),
    if ((detail.dni ?? '').trim().isNotEmpty) ('DNI', detail.dni!.trim()),
    if ((detail.ruc ?? '').trim().isNotEmpty) ('RUC', detail.ruc!.trim()),
  ];

  pw.MemoryImage? photo;
  final path = detail.photoPath;
  if (path != null && path.trim().isNotEmpty) {
    try {
      final file = File(path);
      if (await file.exists()) {
        photo = pw.MemoryImage(await file.readAsBytes());
      }
    } catch (_) {}
  }

  return pdfBlockCard(
    title: 'Datos de contacto',
    icon: PdfDrawnIcon.user,
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pdfUserAvatar(size: 64, photo: photo),
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: name.isEmpty && meta.isEmpty
              ? pw.Text('Perfil sin datos.', style: ProformaPdfTheme.caption())
              : pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    if (name.isNotEmpty) ...[
                      pw.Text(
                        name,
                        style: ProformaPdfTheme.heading().copyWith(
                          fontSize: 13,
                        ),
                      ),
                      if (meta.isNotEmpty) pw.SizedBox(height: 10),
                    ],
                    if (meta.isNotEmpty) _metaGrid(meta),
                  ],
                ),
        ),
      ],
    ),
  );
}

pw.Widget _metaGrid(List<(String, String)> fields) {
  final rows = <pw.Widget>[];
  for (var i = 0; i < fields.length; i += 2) {
    final left = fields[i];
    final right = i + 1 < fields.length ? fields[i + 1] : null;
    rows.add(
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(child: _field(left.$1, left.$2)),
          pw.SizedBox(width: 12),
          pw.Expanded(
            child: right == null
                ? pw.SizedBox()
                : _field(right.$1, right.$2),
          ),
        ],
      ),
    );
    if (i + 2 < fields.length) {
      rows.add(pw.SizedBox(height: 8));
    }
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: rows,
  );
}

pw.Widget _field(String label, String value) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(label, style: ProformaPdfTheme.label()),
      pw.SizedBox(height: 1),
      pw.Text(value, style: ProformaPdfTheme.body()),
    ],
  );
}
