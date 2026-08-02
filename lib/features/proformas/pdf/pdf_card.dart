import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'proforma_pdf_fonts.dart';
import 'proforma_pdf_theme.dart';

pw.Font? _pdfIconsFont;

/// Registra Material Icons solo para este build. Nunca como fontFallback.
void setPdfIconsFont(pw.Font font) => _pdfIconsFont = font;

/// Iconos semánticos del PDF → Material Icons con tamaño acotado.
enum PdfDrawnIcon { table, text, user, wallet, business }

String _glyphFor(PdfDrawnIcon kind) => switch (kind) {
      PdfDrawnIcon.table => PdfMaterialIcons.tableChart,
      PdfDrawnIcon.text => PdfMaterialIcons.notes,
      PdfDrawnIcon.user => PdfMaterialIcons.person,
      PdfDrawnIcon.wallet => PdfMaterialIcons.wallet,
      PdfDrawnIcon.business => PdfMaterialIcons.business,
    };

/// Icono Material Design con dimensiones estrictamente limitadas.
pw.Widget pdfDrawnIcon(
  PdfDrawnIcon kind, {
  double size = 14,
  PdfColor? color,
}) {
  final clamped = size.clamp(8.0, 40.0);
  final c = color ?? ProformaPdfTheme.accent;
  final font = _pdfIconsFont;

  // Caja rígida: evita que el glifo se expanda al ancho de página.
  return pw.SizedBox(
    width: clamped,
    height: clamped,
    child: pw.Container(
      width: clamped,
      height: clamped,
      alignment: pw.Alignment.center,
      child: font == null
          ? _fallbackDot(clamped, c)
          : pw.Text(
              _glyphFor(kind),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              style: pw.TextStyle(
                font: font,
                fontSize: clamped * 0.9,
                color: c,
                height: 1,
                letterSpacing: 0,
                wordSpacing: 0,
              ),
            ),
    ),
  );
}

pw.Widget _fallbackDot(double size, PdfColor color) {
  return pw.Center(
    child: pw.Container(
      width: size * 0.45,
      height: size * 0.45,
      decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
    ),
  );
}

/// Posición de un tramo de card (para paginar sin romper el contorno).
enum PdfCardSegment { alone, start, middle, end }

/// Tarjeta de bloque con título e icono opcional.
pw.Widget pdfBlockCard({
  required String title,
  required pw.Widget child,
  PdfDrawnIcon? icon,
}) {
  return pdfSegmentedCard(
    segment: PdfCardSegment.alone,
    title: title,
    icon: icon,
    child: child,
  );
}

/// Tramo de card: varios widgets top-level que visualmente forman un solo box.
///
/// `package:pdf` solo permite `borderRadius` con borde uniforme (`Border.all`).
/// Por eso start/end usan borde completo + radio parcial; middle solo laterales.
pw.Widget pdfSegmentedCard({
  required PdfCardSegment segment,
  required pw.Widget child,
  String? title,
  PdfDrawnIcon? icon,
}) {
  final r = ProformaPdfTheme.radius;
  final side = pw.BorderSide(color: ProformaPdfTheme.line, width: 0.9);

  // Borde no uniforme ⇒ borderRadius debe ser null (assertion en pdf).
  // start lleva borde inferior (cierra el texto); end no lleva superior
  // para no dibujar una línea entre filas de imágenes.
  final pw.BoxBorder border;
  final pw.BorderRadius? radius;

  switch (segment) {
    case PdfCardSegment.alone:
      border = pw.Border.all(color: ProformaPdfTheme.line, width: 0.9);
      radius = pw.BorderRadius.circular(r);
    case PdfCardSegment.start:
      border = pw.Border.all(color: ProformaPdfTheme.line, width: 0.9);
      radius = pw.BorderRadius.only(
        topLeft: pw.Radius.circular(r),
        topRight: pw.Radius.circular(r),
      );
    case PdfCardSegment.middle:
      border = pw.Border(left: side, right: side);
      radius = null;
    case PdfCardSegment.end:
      border = pw.Border(left: side, right: side, bottom: side);
      radius = null;
  }

  final padding = switch (segment) {
    PdfCardSegment.alone || PdfCardSegment.start =>
      const pw.EdgeInsets.all(ProformaPdfTheme.cardPadding),
    PdfCardSegment.middle => const pw.EdgeInsets.fromLTRB(
        ProformaPdfTheme.cardPadding,
        4,
        ProformaPdfTheme.cardPadding,
        4,
      ),
    PdfCardSegment.end => const pw.EdgeInsets.all(ProformaPdfTheme.cardPadding),
  };

  return pw.Container(
    decoration: pw.BoxDecoration(
      color: ProformaPdfTheme.white,
      border: border,
      borderRadius: radius,
    ),
    padding: padding,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          pdfBlockTitle(title, icon: icon),
          pw.SizedBox(height: 10),
        ],
        child,
      ],
    ),
  );
}

pw.Widget pdfBlockTitle(String title, {PdfDrawnIcon? icon}) {
  return pw.Row(
    children: [
      pw.Container(
        width: 4,
        height: 16,
        decoration: pw.BoxDecoration(
          color: ProformaPdfTheme.accent,
          borderRadius: pw.BorderRadius.circular(2),
        ),
      ),
      pw.SizedBox(width: 8),
      if (icon != null) ...[
        pdfDrawnIcon(icon, size: 14),
        pw.SizedBox(width: 6),
      ],
      pw.Expanded(
        child: pw.Text(title, style: ProformaPdfTheme.heading()),
      ),
    ],
  );
}

/// Chip compacto (código, badges de pago, etc.).
pw.Widget pdfChip(
  String text, {
  PdfColor? background,
  PdfColor? foreground,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: pw.BoxDecoration(
      color: background ?? ProformaPdfTheme.chipBg,
      borderRadius: pw.BorderRadius.circular(20),
      border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.7),
    ),
    child: pw.Text(
      text,
      style: ProformaPdfTheme.caption().copyWith(
        color: foreground ?? ProformaPdfTheme.ink,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
}

/// Contenedor con borde redondeado ligero (logo, foto, imagen).
pw.Widget pdfFramed({
  required pw.Widget child,
  double? width,
  double? height,
  double radius = 6,
}) {
  return pw.Container(
    width: width,
    height: height,
    decoration: pw.BoxDecoration(
      borderRadius: pw.BorderRadius.circular(radius),
      border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.8),
      color: ProformaPdfTheme.white,
    ),
    child: child,
  );
}

/// Avatar circular: foto de usuario o placeholder Material person.
pw.Widget pdfUserAvatar({
  double size = 56,
  pw.ImageProvider? photo,
}) {
  if (photo != null) {
    return pw.Container(
      width: size,
      height: size,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.8),
        image: pw.DecorationImage(image: photo, fit: pw.BoxFit.cover),
      ),
    );
  }

  final box = size.clamp(24.0, 72.0);
  return pw.Container(
    width: box,
    height: box,
    alignment: pw.Alignment.center,
    decoration: pw.BoxDecoration(
      color: const PdfColor.fromInt(0xFFE8E8E8),
      borderRadius: pw.BorderRadius.circular(6),
      border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.8),
    ),
    child: pdfDrawnIcon(
      PdfDrawnIcon.user,
      size: box * 0.5,
      color: const PdfColor.fromInt(0xFF8A8A8A),
    ),
  );
}

/// Placeholder cuadrado con icono o iniciales.
pw.Widget pdfPlaceholderBox({
  double size = 56,
  String? initials,
  PdfDrawnIcon? icon,
}) {
  final box = size.clamp(24.0, 72.0);
  final label = (initials ?? '').trim();
  return pw.Container(
    width: box,
    height: box,
    alignment: pw.Alignment.center,
    decoration: pw.BoxDecoration(
      color: ProformaPdfTheme.accentSoft,
      borderRadius: pw.BorderRadius.circular(6),
      border: pw.Border.all(color: ProformaPdfTheme.line),
    ),
    child: icon != null
        ? pdfDrawnIcon(icon, size: box * 0.42)
        : label.isEmpty
            ? pw.Container(
                width: box * 0.28,
                height: box * 0.28,
                decoration: pw.BoxDecoration(
                  color: ProformaPdfTheme.accent,
                  borderRadius: pw.BorderRadius.circular(3),
                ),
              )
            : pw.Text(
                label.length > 2 ? label.substring(0, 2) : label,
                style: ProformaPdfTheme.heading().copyWith(
                  color: ProformaPdfTheme.accent,
                ),
              ),
  );
}
