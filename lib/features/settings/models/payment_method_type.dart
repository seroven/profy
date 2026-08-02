enum PaymentMethodType {
  yape,
  plin,
  bankAccount;

  String get code => switch (this) {
        PaymentMethodType.yape => 'yape',
        PaymentMethodType.plin => 'plin',
        PaymentMethodType.bankAccount => 'bank_account',
      };

  String get label => switch (this) {
        PaymentMethodType.yape => 'Yape',
        PaymentMethodType.plin => 'Plin',
        PaymentMethodType.bankAccount => 'Cuenta bancaria',
      };

  static PaymentMethodType fromCode(String code) {
    return PaymentMethodType.values.firstWhere(
      (item) => item.code == code,
      orElse: () => PaymentMethodType.yape,
    );
  }
}
