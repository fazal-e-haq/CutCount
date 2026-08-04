import 'package:flutter/material.dart';

const ColorScheme _lightColorScheme = ColorScheme.light(
  primary: Color(0xffE95401),
  onPrimary: Colors.white,
  secondary: Color(0xFF8C4F2B),
  onSecondary: Colors.white,
  surface: Color(0xFFFDFBF7),
  onSurface: Color(0xFF2B2722),
  error: Color(0xFFBA1A1A),
  onError: Colors.white,
  outline: Color(0xFF857364),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: const Color(0xfff5ede0),
  colorScheme: _lightColorScheme,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.4,
      wordSpacing: 0.2,
      height: 1.4,
      color: _lightColorScheme.onSurface.withValues(alpha: 0.7),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.25,
      wordSpacing: 0.2,
      height: 1.5,
      color: _lightColorScheme.onSurface.withValues(alpha: 0.85),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
      wordSpacing: 0.25,
      height: 1.5,
      color: _lightColorScheme.onSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.3,
      color: _lightColorScheme.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.25,
      color: _lightColorScheme.onSurface,
    ),
    headlineLarge: TextStyle(
      fontSize: 26,
      fontFamily: 'Unbounded',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.25,
      wordSpacing: 0.0,
      height: 1.2,
      color: _lightColorScheme.onSurface,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xfff5ede0),
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xFF181512)),
    actionsIconTheme: IconThemeData(color: Color(0xFF181512)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Color(0xFF181512),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    sizeConstraints: BoxConstraints(
      maxHeight: 60,
      minHeight: 59,
      maxWidth: 60,
      minWidth: 59,
    ),
    shape: CircleBorder(),
    iconSize: 26,
    elevation: 0,
    backgroundColor: Color(0xffE95401),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffE95401),
      foregroundColor: Colors.white,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xffE95401),
      side: const BorderSide(color: Color(0xffE95401), width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xffE95401),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFFFDFBF7),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFFEBE2D5), width: 1),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFEBE2D5),
    thickness: 1,
    space: 16,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFFDFBF7),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFF857364),
    ),
    labelStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFF4A433A),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFEBE2D5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFEBE2D5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xffE95401), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 2),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xffE95401);
      }
      return const Color(0xFF857364);
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0x80E95401);
      }
      return const Color(0xFFEBE2D5);
    }),
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    minTileHeight: 40,
  ),
);
