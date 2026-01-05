import 'package:cut_count/screens/bottom_bar.dart';
import 'package:cut_count/screens/home_screen.dart';
import 'package:cut_count/screens/sign_in_screen.dart';
import 'package:cut_count/screens/sign_up_screen.dart';
import 'package:cut_count/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

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
