import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';

/// Persistencia local de sesión con control de inactividad.
class SessionService {
  SessionService(this._prefs);

  final SharedPreferences _prefs;

  static const _userIdKey = 'session_user_id';
  static const _lastActivityKey = 'session_last_activity';

  Future<void> saveSession(int userId) async {
    final now = DateTime.now().toIso8601String();
    await _prefs.setInt(_userIdKey, userId);
    await _prefs.setString(_lastActivityKey, now);
  }

  Future<void> touch() async {
    if (!_prefs.containsKey(_userIdKey)) return;
    await _prefs.setString(
      _lastActivityKey,
      DateTime.now().toIso8601String(),
    );
  }

  /// Devuelve el userId si la sesión sigue vigente; si expiró, la limpia.
  Future<int?> getValidUserId() async {
    final userId = _prefs.getInt(_userIdKey);
    final lastActivityRaw = _prefs.getString(_lastActivityKey);

    if (userId == null || lastActivityRaw == null) {
      return null;
    }

    final lastActivity = DateTime.tryParse(lastActivityRaw);
    if (lastActivity == null) {
      await clear();
      return null;
    }

    final inactiveFor = DateTime.now().difference(lastActivity);
    if (inactiveFor >= AppConstants.sessionInactivityTimeout) {
      await clear();
      return null;
    }

    return userId;
  }

  Future<void> clear() async {
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_lastActivityKey);
  }
}
