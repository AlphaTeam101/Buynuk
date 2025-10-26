import 'package:flutter/material.dart';

/// A class that holds all the color constants for the application.
class AppColors {
  // This class is not meant to be instantiated.
  AppColors._();

  // --- ORIGINAL BRAND COLORS (BLUE FOCUS) ---
  static const Color brandPrimary = Color(0xFF4A90E2); // Original Blue
  static const Color brandSecondary = Color(0xFF50E3C2); // Teal/Mint
  static const Color brandTertiary = Color(0xFFB8E986); // Light Green

  // --- TEXT & ICONS COLORS ---
  static const Color textIconsPrimary = Color(0xFF212121); // Darkest Gray/Black for main text
  static const Color textIconsSecondary = Color(0xFF888888); // Lighter Gray
  static const Color textIconsTertiary = Color(0xFFCCCCCC); // Even Lighter Gray
  static const Color textIconsOnDark = Color(0xFFFFFFFF); // White for text on dark backgrounds
  static const Color textIconsPrimaryDark78 = Color(0xC7FFFFFF);

  // --- SURFACE COLORS ---
  static const Color surfacePrimary = Color(0xFFF9F9F9); // Very light gray for background
  static const Color surfaceSecondary = Color(0xFFFFFFFF); // White for cards
  static const Color surfaceTertiary = Color(0xFFF0F0F0); // Light Gray for placeholders/dividers
  static const Color surfaceDark = Color(0xFF212121); // Dark background for featured sections
  static const Color surfaceQuaternary = Color(0xFFDDDDDD);
  static const Color surfacePrimaryDark = Color(0xFF1C1B1F);

  // --- FEEDBACK & SPECIAL COLORS ---
  static const Color feedbackSuccess = Color(0xFF7ED321); // Green
  static const Color feedbackWarning = Color(0xFFF5A623); // Orange
  static const Color feedbackError = Color(0xFFD0021B);   // Red for errors and Flash Sales
  static const Color feedbackInfo = Color(0xFF4A90E2);    // Blue
}
