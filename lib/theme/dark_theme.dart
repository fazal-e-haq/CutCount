import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff1A1A1A),
textTheme: TextTheme(
bodySmall:    GoogleFonts.poppins(

    color: Colors.grey,
    fontSize: 14,

    fontWeight: .w300
),
  bodyMedium: GoogleFonts.poppins(

  color: Colors.white,
  fontSize: 22,
fontWeight: .w500
),
  headlineMedium:  GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 20,
      fontWeight: .w500
  ),
  headlineLarge: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 30,
      fontWeight: .w600
  ),
),

);