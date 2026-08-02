/// Constantes globales de la aplicación.
abstract final class AppConstants {
  static const String appName = 'Profy';
  static const String databaseName = 'profy';

  /// Tiempo máximo de inactividad antes de cerrar la sesión.
  static const Duration sessionInactivityTimeout = Duration(hours: 2);

  /// Duración mínima percibida en lecturas/escrituras a base de datos.
  static const Duration minDbActionDuration = Duration(milliseconds: 1500);

  static const int minUsernameLength = 3;
  static const int minPasswordLength = 6;
}
