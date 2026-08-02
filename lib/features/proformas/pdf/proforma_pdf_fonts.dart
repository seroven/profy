/// Fuentes dedicadas al PDF (Noto Sans + Material Icons).
///
/// Poppins se mantiene en la UI.
/// Material Icons NO debe usarse como fontFallback del tema (rompe el layout).
abstract final class ProformaPdfFonts {
  static const String regular = 'assets/fonts/pdf/NotoSans-Regular.ttf';
  static const String bold = 'assets/fonts/pdf/NotoSans-Bold.ttf';
  static const String italic = 'assets/fonts/pdf/NotoSans-Italic.ttf';
  static const String boldItalic = 'assets/fonts/pdf/NotoSans-BoldItalic.ttf';
  static const String materialIcons =
      'assets/fonts/pdf/MaterialIcons-Regular.ttf';
}

/// Codepoints de Material Icons (fuente MaterialIcons-Regular.ttf).
abstract final class PdfMaterialIcons {
  static String of(int codePoint) => String.fromCharCode(codePoint);

  static final String tableChart = of(0xe265); // table_chart
  static final String notes = of(0xe26c); // notes
  static final String person = of(0xe7fd); // person
  static final String wallet = of(0xe850); // account_balance_wallet
  static final String business = of(0xe0af); // business
}
