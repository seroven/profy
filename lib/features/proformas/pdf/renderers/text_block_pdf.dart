import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

import '../../models/proforma_document.dart';
import '../pdf_card.dart';
import '../proforma_pdf_theme.dart';

/// Ancho útil aproximado del contenido A4.
const double _contentWidth = 480;

/// Bloque de texto: un solo widget (sin partir para paginación).
Future<List<pw.Widget>> buildTextBlockPdf(ProformaTextBlock block) async {
  final title = (block.title ?? '').trim();
  final heading = title.isEmpty ? 'Texto' : title;

  final images = <pw.MemoryImage>[];
  for (final path in block.imagePaths) {
    final bytes = await _readBytes(path);
    if (bytes != null) {
      images.add(pw.MemoryImage(bytes));
    }
  }

  final children = <pw.Widget>[
    if (block.content.trim().isNotEmpty)
      ..._contentParagraphs(block.content)
    else
      pw.Text('Sin contenido.', style: ProformaPdfTheme.caption()),
  ];

  if (images.isNotEmpty) {
    children.add(pw.SizedBox(height: 8));
    final rows = _mosaicRows(images);
    for (var i = 0; i < rows.length; i++) {
      children.add(rows[i]);
      if (i < rows.length - 1) children.add(pw.SizedBox(height: 8));
    }
  }

  return [
    pdfBlockCard(
      title: heading,
      icon: PdfDrawnIcon.text,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: children,
      ),
    ),
  ];
}

List<pw.Widget> _mosaicRows(List<pw.MemoryImage> images) {
  const gap = 8.0;
  const maxTileHeight = 170.0;
  final tileMaxW = (_contentWidth - gap) / 2;
  final rows = <pw.Widget>[];

  if (images.length == 1) {
    rows.add(
      _mosaicTile(
        images.first,
        maxWidth: _contentWidth,
        maxHeight: 220,
      ),
    );
    return rows;
  }

  for (var i = 0; i < images.length; i += 2) {
    if (i + 1 < images.length) {
      rows.add(
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _mosaicTile(
              images[i],
              maxWidth: tileMaxW,
              maxHeight: maxTileHeight,
            ),
            pw.SizedBox(width: gap),
            _mosaicTile(
              images[i + 1],
              maxWidth: tileMaxW,
              maxHeight: maxTileHeight,
            ),
          ],
        ),
      );
    } else {
      rows.add(
        _mosaicTile(
          images[i],
          maxWidth: tileMaxW,
          maxHeight: maxTileHeight,
        ),
      );
    }
  }

  return rows;
}

pw.Widget _mosaicTile(
  pw.MemoryImage image, {
  required double maxWidth,
  required double maxHeight,
}) {
  final srcW = (image.width ?? 1).toDouble().clamp(1, 100000);
  final srcH = (image.height ?? 1).toDouble().clamp(1, 100000);
  final aspect = srcW / srcH;

  var width = maxWidth;
  var height = width / aspect;
  if (height > maxHeight) {
    height = maxHeight;
    width = height * aspect;
  }

  return pdfFramed(
    width: width,
    height: height,
    child: pw.Image(
      image,
      width: width,
      height: height,
      fit: pw.BoxFit.contain,
    ),
  );
}

List<pw.Widget> _contentParagraphs(String content) {
  final lines = content.replaceAll('\r\n', '\n').split('\n');
  final widgets = <pw.Widget>[];

  for (final line in lines) {
    final trimmed = line.trimRight();
    if (trimmed.isEmpty) {
      widgets.add(pw.SizedBox(height: 4));
      continue;
    }

    final isBullet = trimmed.startsWith('- ') || trimmed.startsWith('* ');
    if (isBullet) {
      final text = trimmed.substring(2).trimLeft();
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 3, left: 2),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 14,
                alignment: pw.Alignment.topLeft,
                child: pw.Text(
                  '-',
                  style: ProformaPdfTheme.body().copyWith(
                    color: ProformaPdfTheme.accent,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(text, style: ProformaPdfTheme.body()),
              ),
            ],
          ),
        ),
      );
    } else {
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 3),
          child: pw.Text(trimmed, style: ProformaPdfTheme.body()),
        ),
      );
    }
  }

  return widgets;
}

Future<Uint8List?> _readBytes(String path) async {
  try {
    final file = File(path);
    if (!await file.exists()) return null;
    return await file.readAsBytes();
  } catch (_) {
    return null;
  }
}
