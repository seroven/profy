import 'dart:math';

/// Genera códigos tipo `PR-2026-928321`.
abstract final class ProformaCodeGenerator {
  static final _random = Random();

  static String generate({DateTime? now}) {
    final year = (now ?? DateTime.now()).year;
    final digits = List.generate(6, (_) => _random.nextInt(10)).join();
    return 'PR-$year-$digits';
  }
}
