import 'package:go_router/go_router.dart';

import '../features/bottom_nav_bar/screens/bottom_bar.dart';
import '../features/onboard/screens/onboarding_screen.dart';
import '../features/settings/screens/setting_screen.dart';

GoRouter router(bool isSeen) => GoRouter(
  initialLocation: isSeen ? '/BottomBar' : '/Onboard',

  routes: [
    GoRoute(
      name: '/Onboard',
      path: '/Onboard',
      builder: (context, state) => OnboardScreen(),
    ),

    GoRoute(
      name: '/BottomBar',
      path: '/BottomBar',
      builder: (context, state) => BottomBar(),
    ),

  //   GoRoute(
  //     name: '/Setting',
  //     path: '/Setting',
  //     builder: (context, state) => SettingScreen(),
  //   ),
  ],
);
