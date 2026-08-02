import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_motion.dart';
import 'app_tab.dart';

/// Controla la dirección del slide entre tabs del shell.
abstract final class TabSlideDirection {
  static int _currentIndex = AppTab.proformas.index;

  static bool resolveForward(AppTab next) {
    final forward = next.index >= _currentIndex;
    _currentIndex = next.index;
    return forward;
  }

  static void reset() {
    _currentIndex = AppTab.proformas.index;
  }
}

CustomTransitionPage<void> buildTabSlidePage({
  required LocalKey key,
  required Widget child,
  required bool forward,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: AppMotion.normal,
    reverseTransitionDuration: AppMotion.fast,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final enterBegin = Offset(forward ? 1 : -1, 0);
      final exitEnd = Offset(forward ? -0.15 : 0.15, 0);

      final enter = Tween<Offset>(begin: enterBegin, end: Offset.zero).animate(
        CurvedAnimation(parent: animation, curve: AppMotion.entrance),
      );
      final exit = Tween<Offset>(begin: Offset.zero, end: exitEnd).animate(
        CurvedAnimation(parent: secondaryAnimation, curve: AppMotion.exit),
      );

      return SlideTransition(
        position: exit,
        child: SlideTransition(
          position: enter,
          child: child,
        ),
      );
    },
  );
}
