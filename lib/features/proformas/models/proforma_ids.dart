import 'dart:math';

abstract final class ProformaIds {
  static final _random = Random();

  static String next([String prefix = 'id']) {
    final millis = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final salt = _random.nextInt(1 << 20).toRadixString(36);
    return '${prefix}_$millis$salt';
  }
}
