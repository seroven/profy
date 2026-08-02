import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import '../../../../core/database/app_database.dart';
import '../pdf_card.dart';
import '../proforma_pdf_theme.dart';

/// Bloque perfil en card moderna.
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

  final fields = <(String, String)>[
    if (name.isNotEmpty) ('NOMBRE', name),
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
        pdfUserAvatar(size: 56, photo: photo),
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: fields.isEmpty
              ? pw.Text('Perfil sin datos.', style: ProformaPdfTheme.caption())
              : pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < fields.length; i++) ...[
                      _field(fields[i].$1, fields[i].$2),
                      if (i < fields.length - 1) pw.SizedBox(height: 6),
                    ],
                  ],
                ),
        ),
      ],
    ),
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
