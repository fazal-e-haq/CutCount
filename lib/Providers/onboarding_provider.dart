import 'package:cut_count/Models/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  int currentIndex = 0;
  final PageController pageController = PageController();
  static const String _keySeenOnboard = 'seen_onboarding';

  final List<OnboardData> introInfo = [
    OnboardData(
      imagePath: 'assets/images/splash.png',
      mainTitle: 'Barber Shop\nManager.',
      subTitle:
          'Manage your entire barbershop operations, customers, and services in one simple offline system daily.',
    ),
    OnboardData(
      imagePath: 'assets/images/HairCutting.jpeg',
      mainTitle: 'Instant Haircut\nLogging.',
      subTitle:
          'Quickly record each haircut and service price without delays or internet connection required.',
    ),
    OnboardData(
      imagePath: 'assets/images/pic.png',
      mainTitle: 'Daily Earnings\nTracker.',
      subTitle:
          'Automatically calculate total daily income and monitor your business performance anytime completely offline and secure.',
    ),
  ];

  Future<void> setOnboardingSeen() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(_keySeenOnboard, true);
    notifyListeners();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
