import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/navigation/app_tab.dart';
import '../../app/theme/app_motion.dart';
import 'acrylic_surface.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.currentTab,
  });

  final AppTab currentTab;

  static const _items = <({AppTab tab, IconData icon, IconData selectedIcon})>[
    (
      tab: AppTab.proformas,
      icon: Icons.description_outlined,
      selectedIcon: Icons.description_rounded,
    ),
    (
      tab: AppTab.comprobantes,
      icon: Icons.payments_outlined,
      selectedIcon: Icons.payments_rounded,
    ),
    (
      tab: AppTab.plantillas,
      icon: Icons.dashboard_customize_outlined,
      selectedIcon: Icons.dashboard_customize_rounded,
    ),
    (
      tab: AppTab.configuracion,
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomInset + 12),
      child: AcrylicSurface(
        borderRadius: BorderRadius.circular(28),
        blur: 24,
        tint: colorScheme.primary,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.12 : 0.16,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            for (final item in _items)
              Expanded(
                child: _NavIconButton(
                  label: item.tab.screenLabel,
                  icon: currentTab == item.tab ? item.selectedIcon : item.icon,
                  selected: currentTab == item.tab,
                  onTap: () {
                    if (currentTab == item.tab) return;
                    context.go(item.tab.routePath);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: label,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        splashColor: colorScheme.primary.withValues(alpha: 0.16),
        highlightColor: colorScheme.primary.withValues(alpha: 0.08),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: AppMotion.standard,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.22)
                : Colors.transparent,
          ),
          child: AnimatedScale(
            scale: selected ? 1.08 : 1,
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            child: Icon(
              icon,
              size: 24,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
        ),
      ),
    );
  }
}
