import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  late TextTheme textTheme;

  static TextTheme customTextTheme() => TextTheme(
        displayLarge: GoogleFonts.lato(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.lato(
          fontSize: 20,
          fontStyle: FontStyle.normal,
        ),
        displaySmall: GoogleFonts.lato(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.lato(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.lato(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: GoogleFonts.lato(
          fontSize: 12,
        ),
        titleMedium: GoogleFonts.lato(
          fontSize: 11,
        ),
        titleSmall: GoogleFonts.lato(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 8,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
      );
}
