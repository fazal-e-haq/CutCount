import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'package:cut_count/routes/app_route.dart';

import 'data/database/isar_service.dart';

import 'features/history/providers/history_provider.dart';
import 'features/onboard/providers/onboarding_provider.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/services/providers/services_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar database service
  final isarService = IsarService();
  await isarService.db;
  // Read persisted onboarding and theme state before building the app shell.
  final prefs = await SharedPreferences.getInstance();
  final isSeen = prefs.getBool("seen_onboarding") ?? false;
  final appRouter = router(isSeen);

  runApp(
    MultiProvider(
      providers: [
        // App-wide state is created once here so navigation and theme changes stay stable.
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => ServicesProvider(isarService)),
        ChangeNotifierProvider(create: (context) => HistoryProvider(isarService)),
        ChangeNotifierProvider(create: (context) => SettingsProvider(prefs)),
      ],
      child: CutCountApp(routerConfig: appRouter),
    ),
  );
}

class CutCountApp extends StatelessWidget {
  const CutCountApp({super.key, required this.routerConfig});
  final GoRouter routerConfig;
  @override
  Widget build(BuildContext context) {
    // Theme mode is driven by persisted settings, while routing stays stable.
    final settings = context.watch<SettingsProvider>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeAnimationDuration: const Duration(milliseconds: 350),
      themeAnimationCurve: Curves.easeOut,
      themeMode: settings.darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: routerConfig,
    );
  }
}
