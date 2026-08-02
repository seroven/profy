import 'package:flutter_test/flutter_test.dart';
import 'package:profy/features/auth/models/password_strength.dart';

void main() {
  test('evalúa fuerza de contraseña', () {
    expect(evaluatePasswordStrength(''), PasswordStrength.empty);
    expect(evaluatePasswordStrength('123'), PasswordStrength.weak);
    expect(evaluatePasswordStrength('abcdef'), PasswordStrength.weak);
    expect(evaluatePasswordStrength('Abcdef1'), PasswordStrength.fair);
    expect(evaluatePasswordStrength('Abcdef1!'), PasswordStrength.good);
    expect(evaluatePasswordStrength('Abcdef12!x'), PasswordStrength.strong);
  });
}
