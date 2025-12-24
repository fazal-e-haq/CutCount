import 'package:cut_count/screens/splash_screen.dart';
import 'package:cut_count/theme/dark_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CutCountApp());
}

class CutCountApp extends StatelessWidget {
  const CutCountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,

      home: const SplashScreen(),
    );
  }
}
