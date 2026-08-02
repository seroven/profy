enum ProformaStatus {
  draft,
  finished;

  String get code => name;

  String get label => switch (this) {
        ProformaStatus.draft => 'Borrador',
        ProformaStatus.finished => 'Terminada',
      };

  static ProformaStatus fromCode(String code) {
    return ProformaStatus.values.firstWhere(
      (item) => item.code == code,
      orElse: () => ProformaStatus.draft,
    );
  }
}
