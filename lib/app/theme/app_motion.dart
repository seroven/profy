import 'package:flutter/animation.dart';

/// Duraciones y curvas compartidas: animaciones limpias y notorias.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 220);
  static const Duration normal = Duration(milliseconds: 420);
  static const Duration slow = Duration(milliseconds: 560);

  static const Curve entrance = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve standard = Curves.easeInOutCubic;
}
