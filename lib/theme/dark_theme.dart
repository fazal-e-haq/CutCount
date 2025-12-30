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
      fontSize: 18,
      fontWeight: .w500,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 23,
      fontWeight: .w600,
    ),
    headlineMedium: GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 20,
      fontWeight: .w500,
    ),
    headlineLarge: GoogleFonts.poppins(
      color: Colors.white54,
      fontSize: 30,
      fontWeight: .w600,
    ),
  ),
);
