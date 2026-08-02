import 'package:flutter/material.dart';

import '../models/password_strength.dart';

class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = evaluatePasswordStrength(password);
    if (strength == PasswordStrength.empty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final color = switch (strength) {
      PasswordStrength.empty => colorScheme.outline,
      PasswordStrength.weak => colorScheme.error,
      PasswordStrength.fair => const Color(0xFFE9A319),
      PasswordStrength.good => colorScheme.tertiary,
      PasswordStrength.strong => const Color(0xFF2E7D32),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: strength.progress,
            minHeight: 6,
            backgroundColor: colorScheme.surfaceContainerHighest,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Seguridad: ${strength.label}',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
