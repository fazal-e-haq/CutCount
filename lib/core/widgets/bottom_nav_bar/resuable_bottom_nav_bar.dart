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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: widget.items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _changePage,
        height: 72,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
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
    );
  }
}
