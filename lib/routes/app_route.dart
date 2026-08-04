import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/bottom_nav_bar/bottom_nav_item.dart';
import '../core/widgets/bottom_nav_bar/resuable_bottom_nav_bar.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/history/screens/history_screen.dart';
import '../features/history/screens/month_history_screen.dart';
import '../features/onboard/screens/onboarding_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/services/screens/services_screen.dart';
import 'routing_name.dart';

// Single routing source of truth for the app.
// Named routes make navigation easier to maintain and safer to refactor.
GoRouter router(bool isSeen) => GoRouter(
  initialLocation: isSeen ? '/home' : '/onboard',
  routes: [
    GoRoute(
      path: '/onboard',
      name: RouteNames.onboard,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/home',
      name: RouteNames.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ReusableBottomBar(
          items: const [
            BottomNavItem(
              page: DashboardScreen(),
              label: 'Dashboard',
              icon: Icons.dashboard_outlined,
              selectedIcon: Icons.dashboard,
            ),
            BottomNavItem(
              page: ServicesScreen(),
              label: 'Services',
              icon: Icons.content_cut_outlined,
              selectedIcon: Icons.content_cut,
            ),
            BottomNavItem(
              page: HistoryScreen(),
              label: 'History',
              icon: Icons.receipt_long_outlined,
              selectedIcon: Icons.receipt_long,
            ),
            BottomNavItem(
              page: ProfileScreen(),
              label: 'Profile',
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
            ),
          ],
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/settings',
      name: RouteNames.settings,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    ),
    GoRoute(
      path: '/history-month',
      name: RouteNames.historyMonth,
      pageBuilder: (context, state) {
        // Month detail data is passed through `extra` so the history list can stay simple.
        final month = state.extra as dynamic;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MonthHistoryScreen(monthHistory: month),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Slide up from bottom
            const end = Offset.zero;
            const curve = Curves.easeOutExpo;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    ),
  ],
);
