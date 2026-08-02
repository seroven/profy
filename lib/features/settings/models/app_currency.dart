enum AppCurrency {
  pen,
  usd,
  eur;

  String get code => switch (this) {
        AppCurrency.pen => 'PEN',
        AppCurrency.usd => 'USD',
        AppCurrency.eur => 'EUR',
      };

  String get label => switch (this) {
        AppCurrency.pen => 'Soles',
        AppCurrency.usd => 'Dólares',
        AppCurrency.eur => 'Euros',
      };

  /// Prefijo monetario para montos (PDF / reportes).
  String get prefix => switch (this) {
        AppCurrency.pen => 'S/. ',
        AppCurrency.usd => '\$ ',
        AppCurrency.eur => '€ ',
      };

  static AppCurrency fromCode(String code) {
    return AppCurrency.values.firstWhere(
      (item) => item.code == code,
      orElse: () => AppCurrency.pen,
    );
  }
}
