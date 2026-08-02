import '../constants/app_constants.dart';

/// Garantiza que una acción async dure al menos [minDuration]
/// (útil para que la carga se perciba aunque la BD sea local e inmediata).
Future<T> withMinDuration<T>(
  Future<T> Function() action, {
  Duration minDuration = AppConstants.minDbActionDuration,
}) async {
  final started = DateTime.now();

  try {
    final result = await action();
    await _waitRemaining(started, minDuration);
    return result;
  } catch (error, stackTrace) {
    await _waitRemaining(started, minDuration);
    Error.throwWithStackTrace(error, stackTrace);
  }
}

Future<void> _waitRemaining(DateTime started, Duration minDuration) async {
  final elapsed = DateTime.now().difference(started);
  final remaining = minDuration - elapsed;
  if (remaining > Duration.zero) {
    await Future<void>.delayed(remaining);
  }
}
