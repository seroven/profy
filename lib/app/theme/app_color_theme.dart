import 'package:flutter/material.dart';

/// Paletas de color disponibles para el tema de la app.
enum AppColorTheme {
  blue,
  red,
  celeste,
  green,
  yellow,
  gray,
  orange,
  cyan,
  purple;

  Color get seedColor => switch (this) {
        AppColorTheme.blue => const Color(0xFF1565C0),
        AppColorTheme.red => const Color(0xFFC62828),
        AppColorTheme.celeste => const Color(0xFF039BE5),
        AppColorTheme.green => const Color(0xFF2E7D32),
        AppColorTheme.yellow => const Color(0xFFF9A825),
        AppColorTheme.gray => const Color(0xFF546E7A),
        AppColorTheme.orange => const Color(0xFFEF6C00),
        AppColorTheme.cyan => const Color(0xFF00838F),
        AppColorTheme.purple => const Color(0xFF6A1B9A),
      };
}
