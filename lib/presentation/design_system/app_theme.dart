import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// A custom theme extension for holding a richer set of semantic colors.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.brandSecondary,
    required this.brandTertiary,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.surfaceQuaternary,
    required this.textIconsSecondary,
    required this.textIconsTertiary,
    required this.textIconsQuaternary,
    required this.feedbackSuccess,
    required this.feedbackWarning,
    required this.feedbackInfo,
    required this.paletteRed100,
    required this.paletteGreen100,
    required this.paletteBlue100,
  });

  final Color? brandSecondary;
  final Color? brandTertiary;
  final Color? surfaceSecondary;
  final Color? surfaceTertiary;
  final Color? surfaceQuaternary;
  final Color? textIconsSecondary;
  final Color? textIconsTertiary;
  final Color? textIconsQuaternary;
  final Color? feedbackSuccess;
  final Color? feedbackWarning;
  final Color? feedbackInfo;
  final Color? paletteRed100;
  final Color? paletteGreen100;
  final Color? paletteBlue100;

  @override
  AppColorsExtension copyWith({
    Color? brandSecondary,
    Color? brandTertiary,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
    Color? surfaceQuaternary,
    Color? textIconsSecondary,
    Color? textIconsTertiary,
    Color? textIconsQuaternary,
    Color? feedbackSuccess,
    Color? feedbackWarning,
    Color? feedbackInfo,
    Color? paletteRed100,
    Color? paletteGreen100,
    Color? paletteBlue100,
  }) {
    return AppColorsExtension(
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandTertiary: brandTertiary ?? this.brandTertiary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      surfaceQuaternary: surfaceQuaternary ?? this.surfaceQuaternary,
      textIconsSecondary: textIconsSecondary ?? this.textIconsSecondary,
      textIconsTertiary: textIconsTertiary ?? this.textIconsTertiary,
      textIconsQuaternary: textIconsQuaternary ?? this.textIconsQuaternary,
      feedbackSuccess: feedbackSuccess ?? this.feedbackSuccess,
      feedbackWarning: feedbackWarning ?? this.feedbackWarning,
      feedbackInfo: feedbackInfo ?? this.feedbackInfo,
      paletteRed100: paletteRed100 ?? this.paletteRed100,
      paletteGreen100: paletteGreen100 ?? this.paletteGreen100,
      paletteBlue100: paletteBlue100 ?? this.paletteBlue100,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      brandSecondary: Color.lerp(brandSecondary, other.brandSecondary, t),
      brandTertiary: Color.lerp(brandTertiary, other.brandTertiary, t),
      surfaceSecondary: Color.lerp(surfaceSecondary, other.surfaceSecondary, t),
      surfaceTertiary: Color.lerp(surfaceTertiary, other.surfaceTertiary, t),
      surfaceQuaternary: Color.lerp(surfaceQuaternary, other.surfaceQuaternary, t),
      textIconsSecondary: Color.lerp(textIconsSecondary, other.textIconsSecondary, t),
      textIconsTertiary: Color.lerp(textIconsTertiary, other.textIconsTertiary, t),
      textIconsQuaternary: Color.lerp(textIconsQuaternary, other.textIconsQuaternary, t),
      feedbackSuccess: Color.lerp(feedbackSuccess, other.feedbackSuccess, t),
      feedbackWarning: Color.lerp(feedbackWarning, other.feedbackWarning, t),
      feedbackInfo: Color.lerp(feedbackInfo, other.feedbackInfo, t),
      paletteRed100: Color.lerp(paletteRed100, other.paletteRed100, t),
      paletteGreen100: Color.lerp(paletteGreen100, other.paletteGreen100, t),
      paletteBlue100: Color.lerp(paletteBlue100, other.paletteBlue100, t),
    );
  }
}

/// A class that holds the theme data for the application.
class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.brandPrimary,
    scaffoldBackgroundColor: AppColors.surfacePrimary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.brandPrimary,
      secondary: AppColors.brandSecondary,
      surface: AppColors.surfacePrimary,
      onSurface: AppColors.textIconsPrimaryDark, // Text on surface
      error: AppColors.feedbackError,
    ),
    textTheme: _buildTextTheme(AppColors.textIconsPrimaryDark),
    extensions: const <ThemeExtension<dynamic>>[
      AppColorsExtension(
        brandSecondary: AppColors.brandSecondary,
        brandTertiary: AppColors.brandTertiary,
        surfaceSecondary: AppColors.surfaceSecondary,
        surfaceTertiary: AppColors.surfaceTertiary,
        surfaceQuaternary: AppColors.surfaceQuaternary,
        textIconsSecondary: AppColors.textIconsSecondary,
        textIconsTertiary: AppColors.textIconsTertiary,
        textIconsQuaternary: AppColors.textIconsQuaternary,
        feedbackSuccess: AppColors.feedbackSuccess,
        feedbackWarning: AppColors.feedbackWarning,
        feedbackInfo: AppColors.feedbackInfo,
        paletteRed100: AppColors.paletteRed100,
        paletteGreen100: AppColors.paletteGreen100,
        paletteBlue100: AppColors.paletteBlue100,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.brandPrimary,
    scaffoldBackgroundColor: const Color(0xFF121212), // Dark grey background
    colorScheme: const ColorScheme.dark(
      primary: AppColors.brandPrimary,
      secondary: AppColors.brandSecondary,
      surface: Color(0xFF1E1E1E), // Slightly lighter surface color
      onSurface: Color(0xFFE0E0E0), // High-emphasis text
      error: AppColors.feedbackError,
    ),
    textTheme: _buildTextTheme(const Color(0xFFE0E0E0)), // High-emphasis text
    extensions: <ThemeExtension<dynamic>>[
      AppColorsExtension(
        brandSecondary: AppColors.brandSecondary,
        brandTertiary: AppColors.brandTertiary.withOpacity(0.5),
        surfaceSecondary: const Color(0xFF1E1E1E),
        surfaceTertiary: const Color(0xFF2C2C2C),
        surfaceQuaternary: const Color(0xFF3A3A3A),
        textIconsSecondary: const Color(0xFFBDBDBD), // Medium-emphasis text
        textIconsTertiary: const Color(0xFF9E9E9E), // Disabled/hint text
        textIconsQuaternary: const Color(0xFF757575),
        feedbackSuccess: AppColors.feedbackSuccess,
        feedbackWarning: AppColors.feedbackWarning,
        feedbackInfo: AppColors.feedbackInfo,
        paletteRed100: AppColors.paletteRed100,
        paletteGreen100: AppColors.paletteGreen100,
        paletteBlue100: AppColors.paletteBlue100,
      ),
    ],
  );

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      displayMedium: AppTextStyles.displayMedium.copyWith(color: textColor),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: textColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: textColor),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: textColor),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: textColor),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: textColor),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: textColor),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: textColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: textColor),
    );
  }
}
