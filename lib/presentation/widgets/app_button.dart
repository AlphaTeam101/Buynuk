import 'package:flutter/material.dart';
import '../design_system/app_theme.dart';
import '../design_system/app_colors.dart';

enum AppButtonType {
  primary,
  secondary,
  tertiary,
  destructive,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonType = AppButtonType.primary,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final AppButtonType buttonType;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    Color backgroundColor;
    Color foregroundColor;
    Color disabledBackgroundColor;
    Color disabledForegroundColor;
    BorderSide? borderSide;

    switch (buttonType) {
      case AppButtonType.primary:
        backgroundColor = appColors.brandSecondary!;
        foregroundColor = AppColors.textIconsPrimary;
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
      case AppButtonType.secondary:
        backgroundColor = appColors.surfaceSecondary!;
        foregroundColor = theme.primaryColor;
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        borderSide = BorderSide(color: theme.primaryColor, width: 1);
        break;
      case AppButtonType.tertiary:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.primaryColor;
        disabledBackgroundColor = Colors.transparent;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
      case AppButtonType.destructive:
        backgroundColor = appColors.paletteRed100!;
        foregroundColor = AppColors.textIconsPrimary;
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        disabledForegroundColor: disabledForegroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: borderSide ?? BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: textTheme.labelLarge,
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              width: textTheme.labelLarge!.fontSize! * 1.2,
              height: textTheme.labelLarge!.fontSize! * 1.2,
              child: CircularProgressIndicator(
                color: foregroundColor,
                strokeWidth: 2,
              ),
            )
          : Text(text),
    );
  }
}
