import 'package:flutter/material.dart';

/// A class that holds all the color constants for the application.
class AppColors {
  // This class is not meant to be instantiated.
  AppColors();

  // Brand Colors
  static const Color brandPrimary = Color(0xFF050301);
  static const Color brandSecondary = Color(0xffffd257);
  static const Color brandTertiary = Color(0xFFE5E0FF);

  // Text & Icons Colors
  static const Color textIconsPrimary = Color(0xFFFFFFFF);
  static const Color textIconsSecondary = Color(0xFFC5C2D1);
  static const Color textIconsTertiary = Color(0xFF9B99A9);
  static const Color textIconsQuaternary = Color(0xFF6A687A);
  static const Color textIconsPrimaryDark = Color(0xFF000000);
  static const Color textIconsPrimaryDark78 = Color(0xC7000000);

  // Surface Colors
  static const Color surfacePrimary = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF6F6F8);
  static const Color surfaceTertiary = Color(0xFFE5E0FF);
  static const Color surfaceQuaternary = Color(0xFFC5C2D1);
  static const Color surfacePrimaryDark = Color(0xFF1C1B1F);

  // Feedback Colors
  static const Color feedbackSuccess = Color(0xFF3DD598);
  static const Color feedbackWarning = Color(0xFFF0A553);
  static const Color feedbackError = Color(0xFFF05353);
  static const Color feedbackInfo = Color(0xFF539FF0);

  // Opacity & Tint
  // #FFFFFF with 20% opacity -> 0.2 * 255 = 51 -> 0x33
  static const Color surfaceTint = Color(0x33FFFFFF); 
  // #FFFFFF with 10% opacity -> 0.1 * 255 = 25.5 -> 0x1A
  static const Color surfaceOpacity10 = Color(0x1AFFFFFF);
  // #FFFFFF with 8% opacity -> 0.08 * 255 = 20.4 -> 0x14
  static const Color surfaceOpacity08 = Color(0x14FFFFFF);

  // Color Palette
  static const Color paletteRed100 = Color(0xFFF05353);
  static const Color paletteRed80 = Color(0xFFF37575);
  static const Color paletteRed60 = Color(0xFFF79898);
  static const Color paletteRed40 = Color(0xFFFADADA);
  static const Color paletteRed20 = Color(0xFFFCEEEE);

  static const Color paletteGreen100 = Color(0xFF3DD598);
  static const Color paletteGreen80 = Color(0xFF64DDAA);
  static const Color paletteGreen60 = Color(0xFF8BE5BC);
  static const Color paletteGreen40 = Color(0xFFD7F5E8);
  static const Color paletteGreen20 = Color(0xFFEBF9F3);

  static const Color paletteBlue100 = Color(0xFF539FF0);
  static const Color paletteBlue80 = Color(0xFF75B2F3);
  static const Color paletteBlue60 = Color(0xFF98C5F7);
  static const Color paletteBlue40 = Color(0xFFDAEAFB);
  static const Color paletteBlue20 = Color(0xFFEBF4FD);
}
