import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Tokens del PDF elegante-moderno (paleta slate imprimible).
abstract final class ProformaPdfTheme {
  static const PdfColor ink = PdfColor.fromInt(0xFF1F2933);
  static const PdfColor muted = PdfColor.fromInt(0xFF6B7785);
  static const PdfColor line = PdfColor.fromInt(0xFFD7DEE7);
  /// Borde de celdas de tabla (más legible que [line] en impresión).
  static const PdfColor tableLine = PdfColor.fromInt(0xFF8A97A6);
  static const PdfColor accent = PdfColor.fromInt(0xFF2F3A4A);
  static const PdfColor accentSoft = PdfColor.fromInt(0xFFE8EEF4);
  static const PdfColor sectionBg = PdfColor.fromInt(0xFFDCE4EE);
  static const PdfColor subsectionBg = PdfColor.fromInt(0xFFEEF2F6);
  static const PdfColor zebra = PdfColor.fromInt(0xFFF7F9FB);
  static const PdfColor sumBg = PdfColor.fromInt(0xFFEEF3F8);
  static const PdfColor discountBg = PdfColor.fromInt(0xFFF8F1F1);
  /// Suma/descuento a nivel sección (más marcado que subsección).
  static const PdfColor sectionSumBg = PdfColor.fromInt(0xFFC9D5E3);
  static const PdfColor sectionDiscountBg = PdfColor.fromInt(0xFFE4D0D0);
  static const PdfColor white = PdfColors.white;
  static const PdfColor chipBg = PdfColor.fromInt(0xFFF0F4F8);

  static const double radius = 8;
  static const double cardPadding = 12;

  /// Sin boxShadow: en Android `package:pdf` puede fallar en shadowRect
  /// con `Invalid argument(s): 0`.
  static pw.BoxDecoration get cardDecoration => pw.BoxDecoration(
        color: white,
        borderRadius: pw.BorderRadius.circular(radius),
        border: pw.Border.all(color: line, width: 0.9),
      );

  static pw.TextStyle title() => pw.TextStyle(
        fontSize: 17,
        fontWeight: pw.FontWeight.bold,
        color: ink,
      );

  static pw.TextStyle heading() => pw.TextStyle(
        fontSize: 11.5,
        fontWeight: pw.FontWeight.bold,
        color: ink,
      );

  static pw.TextStyle body() => const pw.TextStyle(
        fontSize: 10,
        color: ink,
      );

  static pw.TextStyle caption() => const pw.TextStyle(
        fontSize: 9,
        color: muted,
      );

  static pw.TextStyle tableHeader() => pw.TextStyle(
        fontSize: 8.5,
        fontWeight: pw.FontWeight.bold,
        color: white,
      );

  static pw.TextStyle tableCell() => const pw.TextStyle(
        fontSize: 9,
        color: ink,
      );

  static pw.TextStyle label() => pw.TextStyle(
        fontSize: 8,
        fontWeight: pw.FontWeight.bold,
        color: muted,
        letterSpacing: 0.3,
      );
}

String pdfFormatDate(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m/${date.year}';
}

String pdfFormatMoney(double value, {String prefix = ''}) =>
    '$prefix${value.toStringAsFixed(2)}';

String pdfStripZeros(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toString();
}
