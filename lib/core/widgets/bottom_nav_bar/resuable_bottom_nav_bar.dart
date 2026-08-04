import 'package:flutter/material.dart';

import 'bottom_nav_item.dart';

class ReusableBottomBar extends StatefulWidget {
  const ReusableBottomBar({
    super.key,
    required this.items,
    this.initialIndex = 0,
  });

  final List<BottomNavItem> items;
  final int initialIndex;

  @override
  State<ReusableBottomBar> createState() => _ReusableBottomBarState();
}

class _ReusableBottomBarState extends State<ReusableBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          height: 72,
          elevation: 0,
          backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          indicatorColor: theme.colorScheme.primary.withValues(alpha: .12),
          animationDuration: const Duration(milliseconds: 300),
          destinations: widget.items.map((item) {
            return NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(
                item.selectedIcon,
                color: theme.colorScheme.primary,
              ),
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}
