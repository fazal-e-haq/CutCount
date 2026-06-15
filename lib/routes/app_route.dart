import 'package:cut_count/presentation/screens/create_services_screen.dart';
import 'package:cut_count/presentation/screens/setting_screen.dart';
import 'package:go_router/go_router.dart';

import '../Providers/onboarding_provider.dart';
import '../presentation/screens/bottom_bar.dart';

import '../presentation/screens/intro_screen.dart';

GoRouter router(bool isSeen) => GoRouter(
  initialLocation: isSeen ? '/BottomBar' : '/BottomBar',

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
    // GoRoute(
    //   name: '/Home',
    //   path: '/Home',
    //   builder: (context, state) => BottomBar(),
    // ),
    GoRoute(
      name: '/Setting',
      path: '/Setting',
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      name: '/CreateService',
      path: '/CreateService',
      builder: (context, state) => CreateServicesScreen(),
    ),
  ],
);
