import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  // Scaffold background color using the user's defined color
  scaffoldBackgroundColor: const Color(0xfff5ede0),

  // Define the core color scheme for the light theme
  colorScheme: const ColorScheme.light(
    primary: Color(0xffE95401),        // Main accent/orange color
    onPrimary: Colors.white,
    secondary: Color(0xFF8C4F2B),      // Warm earthy terracotta brown
    onSecondary: Colors.white,
    surface: Color(0xFFFDFBF7),        // Card and container background
    onSurface: Color(0xFF2B2722),      // Primary text color
    error: Color(0xFFBA1A1A),          // Standard error red
    onError: Colors.white,
    outline: Color(0xFF857364),        // Borders and dividers
  ),

  // Typography / TextTheme matching the local fonts: Inter, Poppins, Unbounded
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.4,
      wordSpacing: 0.2,
      height: 1.4,
      color: Color(0xFF5F564B), // Muted dark brown-gray
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.25,
      wordSpacing: 0.2,
      height: 1.5,
      color: Color(0xFF4A433A), // Medium dark brown-gray
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
      wordSpacing: 0.25,
      height: 1.5,
      color: Color(0xFF3A342C), // Deep dark brown-gray
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.3,
      color: Color(0xFF2B2722), // Deep charcoal
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      height: 1.25,
      color: Color(0xFF1F1B18), // Very deep charcoal
    ),
    headlineLarge: TextStyle(
      fontSize: 26,
      fontFamily: 'Unbounded',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.25,
      wordSpacing: 0.0,
      height: 1.2,
      color: Color(0xFF181512), // Pitch black/charcoal
    ),
  ),

  // AppBar styling
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

  // Floating Action Button styling
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

  // ElevatedButton styling
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffE95401), // Primary accent color
      foregroundColor: Colors.white,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // OutlinedButton styling
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xffE95401),
      side: const BorderSide(color: Color(0xffE95401), width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // TextButton styling
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

  // Card theme styling
  cardTheme: CardThemeData(
    color: const Color(0xFFFDFBF7),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFFEBE2D5), width: 1),
    ),
  ),

  // Divider styling
  dividerTheme: const DividerThemeData(
    color: Color(0xFFEBE2D5),
    thickness: 1,
    space: 16,
  ),

  // Input Field Decoration styling (TextField / TextFormField)
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

  // Switch, Radio and Checkbox styling
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
);

