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

  static AppCurrency fromCode(String code) {
    return AppCurrency.values.firstWhere(
      (item) => item.code == code,
      orElse: () => AppCurrency.pen,
    );
  }
}
