import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff1A1A1A),
textTheme: TextTheme(
bodyMedium: GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 18,
fontWeight: .w400
)
),
);