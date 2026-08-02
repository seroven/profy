enum MeasureUnit {
  m2,
  m3,
  ft,
  cm;

  String get code => switch (this) {
        MeasureUnit.m2 => 'm2',
        MeasureUnit.m3 => 'm3',
        MeasureUnit.ft => 'ft',
        MeasureUnit.cm => 'cm',
      };

  String get label => switch (this) {
        MeasureUnit.m2 => 'Metros cuadrados',
        MeasureUnit.m3 => 'Metros cúbicos',
        MeasureUnit.ft => 'Pies',
        MeasureUnit.cm => 'Centímetros',
      };

  static MeasureUnit fromCode(String code) {
    return MeasureUnit.values.firstWhere(
      (item) => item.code == code,
      orElse: () => MeasureUnit.m2,
    );
  }
}
