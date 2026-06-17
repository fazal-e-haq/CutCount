import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/onboard_model.dart';

class OnboardingProvider with ChangeNotifier {
  int currentIndex = 0;
  final PageController pageController = PageController();
  static const String _keySeenOnboard = 'seen_onboarding';

  final List<OnboardData> introInfo = [
    OnboardData(
      imagePath: 'assets/images/splash.png',
      mainTitle: 'Barbershop Operations\nManagement',
      subTitle:
      'Centralize shop activities including services, records, and daily workflow in a structured offline system.',
    ),
    OnboardData(
      imagePath: 'assets/images/haircut_logging.png',
      mainTitle: 'Fast Service\nRecording',
      subTitle:
      'Log haircut services and pricing instantly with a streamlined interface optimized for daily use.',
    ),
    OnboardData(
      imagePath: 'assets/images/earnings_tracker.png',
      mainTitle: 'Revenue & Performance\nTracking',
      subTitle:
      'Monitor daily earnings and shop performance with automated summaries and historical insights.',
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
