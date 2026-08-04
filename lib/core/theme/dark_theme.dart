import "package:flutter/material.dart";

const ColorScheme _darkColorScheme = ColorScheme.dark(
  primary: Color(0xffE95401),
  onPrimary: Colors.white,
  secondary: Color(0xFFFFA066),
  onSecondary: Colors.black,
  surface: Color(0xff222222),
  onSurface: Color(0xFFE0E0E0),
  error: Color(0xFFCF6679),
  onError: Colors.black,
  outline: Color(0xFF444444),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: const Color(0xff1A1A1A),
  colorScheme: _darkColorScheme,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.4,
      wordSpacing: 0.2,
      height: 1.4,
      color: _darkColorScheme.onSurface.withValues(alpha: 0.7),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.25,
      wordSpacing: 0.2,
      height: 1.5,
      color: _darkColorScheme.onSurface.withValues(alpha: 0.85),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
      wordSpacing: 0.25,
      height: 1.5,
      color: _darkColorScheme.onSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.3,
      color: _darkColorScheme.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.25,
      color: _darkColorScheme.onSurface,
    ),
    headlineLarge: TextStyle(
      fontSize: 26,
      fontFamily: 'Unbounded',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.25,
      wordSpacing: 0.0,
      height: 1.2,
      color: _darkColorScheme.onSurface,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1A1A1A),
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Colors.white,
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
    elevation: 4,
    backgroundColor: Color(0xffE95401),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffE95401),
      foregroundColor: Colors.white,
      elevation: 4,
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
      foregroundColor: const Color(0xffFFA066),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xff222222),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF333333), width: 1),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF333333),
    thickness: 1,
    space: 16,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff222222),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFF888888),
    ),
    labelStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFFCCCCCC),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF333333)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF333333)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xffE95401), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFCF6679)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFCF6679), width: 2),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xffE95401);
      }
      return const Color(0xFF888888);
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0x80E95401);
      }
      return const Color(0xFF333333);
    }),
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    minTileHeight: 40,
  ),
);
