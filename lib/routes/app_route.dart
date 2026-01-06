


import 'package:go_router/go_router.dart';

import '../presentation/screens/bottom_bar.dart';
import '../presentation/screens/sign_in_screen.dart';
import '../presentation/screens/sign_up_screen.dart';
import '../presentation/screens/splash_screen.dart';

GoRouter get router => _router;
final _router = GoRouter(
  initialLocation: '/', // Where the app starts
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

    GoRoute(
      name: '/SignIn',
      path: '/SignIn',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      name: '/SignUp',
      path: '/SignUp',
      builder: (context, state) =>  SignUpScreen(),
    ),
    GoRoute(
      name: '/BottomBar',
      path: '/BottomBar',
      builder: (context, state) =>   BottomBar(),
    ),
  ],
);
