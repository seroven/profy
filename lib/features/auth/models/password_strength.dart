import '../../../core/constants/app_constants.dart';

enum PasswordStrength {
  empty,
  weak,
  fair,
  good,
  strong;

  String get label => switch (this) {
        PasswordStrength.empty => '',
        PasswordStrength.weak => 'Débil',
        PasswordStrength.fair => 'Aceptable',
        PasswordStrength.good => 'Buena',
        PasswordStrength.strong => 'Fuerte',
      };

  double get progress => switch (this) {
        PasswordStrength.empty => 0,
        PasswordStrength.weak => 0.25,
        PasswordStrength.fair => 0.5,
        PasswordStrength.good => 0.75,
        PasswordStrength.strong => 1,
      };
}

PasswordStrength evaluatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;
  if (password.length < AppConstants.minPasswordLength) {
    return PasswordStrength.weak;
  }

  var score = 0;
  if (password.length >= AppConstants.minPasswordLength) score++;
  if (password.length >= 10) score++;
  if (RegExp(r'[A-Z]').hasMatch(password) &&
      RegExp(r'[a-z]').hasMatch(password)) {
    score++;
  }
  if (RegExp(r'\d').hasMatch(password)) score++;
  if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score++;

  if (score <= 2) return PasswordStrength.weak;
  if (score == 3) return PasswordStrength.fair;
  if (score == 4) return PasswordStrength.good;
  return PasswordStrength.strong;
}
