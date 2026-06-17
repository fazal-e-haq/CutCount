import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'package:cut_count/routes/app_route.dart';

import 'features/onboard/providers/onboarding_provider.dart';
import 'features/settings/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isSeen = prefs.getBool("seen_onboarding") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
      ],
      child: CutCountApp(isSeen: isSeen),
    ),
  );
}

class CutCountApp extends StatelessWidget {
  const CutCountApp({super.key, required this.isSeen});
  final bool isSeen;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().isdark ? .dark : .light,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router(isSeen),
    );
  }
}
