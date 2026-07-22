import 'package:flutter/material.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.page,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final Widget page;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
