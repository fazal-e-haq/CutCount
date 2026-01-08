import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff1A1A1A),
  textTheme: TextTheme(
    bodySmall: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 12,

      fontWeight: .w300,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.white54,
      fontSize: 14,
      fontWeight: .w500,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 16,
      fontWeight: .w600,
    ),
    headlineSmall: GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 18,
      fontWeight: .w500,
    ),

    headlineMedium: GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 23,
      fontWeight: .w500,
    ),
    headlineLarge: GoogleFonts.poppins(
      color: Colors.white54,
      fontSize: 26,
      fontWeight: .w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:   Colors.white12, // Primary button color
      foregroundColor: Colors.white, // Text color
      elevation: 4, // Shadow

      textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ),
);
