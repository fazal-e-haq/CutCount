import 'package:flutter/material.dart';

import 'package:cut_count/features/history/screens/history_screen.dart';
import 'package:cut_count/features/services/screens/services_screen.dart';
import 'package:cut_count/features/settings/screens/setting_screen.dart';

import '../../dashboard/screens/dashboard_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  // Controls the PageView programmatically (tap-driven, not finger-driven).
  final PageController _pageController = PageController();

  final List<Widget> _screens = const [
    DashboardScreen(),
    HistoryScreen(),
    ServicesScreen(),
    SettingScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // always dispose controllers
    super.dispose();
  }

  // Called when a nav bar item is tapped.
  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic, // smooth, natural page-glide feel
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // blocks finger swipe
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTabTapped,
        height: 72,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        indicatorColor: primary.withAlpha(30),
        animationDuration: const Duration(milliseconds: 350),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded, color: primary),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded, color: primary),
            label: 'History',
          ),
          NavigationDestination(
            icon: const Icon(Icons.content_cut_outlined),
            selectedIcon: Icon(Icons.content_cut_rounded, color: primary),
            label: 'Services',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded, color: primary),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
