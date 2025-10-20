
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that holds all the text style constants for the application.
class AppTextStyles {
  // This class is not meant to be instantiated.
  AppTextStyles._();

  // Using ibmPlexSansArabic font from Google Fonts
  static final TextStyle _baseTextStyle = GoogleFonts.ibmPlexSansArabic();

  // Display Styles
  static final TextStyle displayMedium = _baseTextStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 52 / 45, // Line height: 52pt
  );

  // Headline Styles
  static final TextStyle headlineLarge = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 40 / 32, // Line height: 40pt
  );

  static final TextStyle headlineMedium = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 36 / 28, // Line height: 36pt
  );

  // Title Styles
  static final TextStyle titleLarge = _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500, // Medium weight
    height: 28 / 22, // Line height: 28pt
  );

  static final TextStyle titleMedium = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium weight
    height: 24 / 16, // Line height: 24pt
    letterSpacing: 0.15,
  );

  static final TextStyle titleSmall = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium weight
    height: 20 / 14, // Line height: 20pt
    letterSpacing: 0.1,
  );

  // Label Styles
  static final TextStyle labelLarge = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium weight
    height: 20 / 14, // Line height: 20pt
    letterSpacing: 0.1,
  );

  static final TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium weight
    height: 16 / 12, // Line height: 16pt
    letterSpacing: 0.5,
  );

  // Body Styles
  static final TextStyle bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16, // Line height: 24pt
    letterSpacing: 0.5,
  );

  static final TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14, // Line height: 20pt
    letterSpacing: 0.25,
  );

  static final TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12, // Line height: 16pt
    letterSpacing: 0.4,
  );
}
