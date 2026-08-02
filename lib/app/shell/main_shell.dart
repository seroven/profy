import 'package:flutter/material.dart';

import '../navigation/app_tab.dart';
import '../../shared/widgets/floating_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  bool get _showFloatingNav =>
      AppTab.values.any((tab) => location == tab.routePath);

  @override
  Widget build(BuildContext context) {
    final currentTab = AppTab.fromLocation(location) ?? AppTab.proformas;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (_showFloatingNav)
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingNavBar(currentTab: currentTab),
            ),
        ],
      ),
    );
  }
}
