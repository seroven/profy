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

  @override
  Widget build(BuildContext context) {
    final currentTab = AppTab.fromLocation(location) ?? AppTab.proformas;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingNavBar(currentTab: currentTab),
          ),
        ],
      ),
    );
  }
}
