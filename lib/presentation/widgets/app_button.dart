import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';

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
    this.leadingIcon,
    this.isFullWidth = false,
    this.textStyle,
    this.padding,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final String text;
  final AppButtonType buttonType;
  final bool isLoading;
  final Widget? leadingIcon;
  final bool isFullWidth;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    Color buttonBackgroundColor;
    Color foregroundColor;
    Color disabledBackgroundColor;
    Color disabledForegroundColor;
    BorderSide? borderSide;

    switch (buttonType) {
      case AppButtonType.primary:
        buttonBackgroundColor = backgroundColor ?? theme.primaryColor;
        foregroundColor = AppColors.textIconsOnDark;
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
      case AppButtonType.secondary:
        buttonBackgroundColor = backgroundColor ?? appColors.surfaceSecondary!;
        foregroundColor = appColors.textIconsSecondary!.withOpacity(0.8);
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        borderSide = BorderSide(color: appColors.surfaceQuaternary!, width: 1.5);
        break;
      case AppButtonType.tertiary:
        buttonBackgroundColor = backgroundColor ?? Colors.transparent;
        foregroundColor = theme.primaryColor;
        disabledBackgroundColor = Colors.transparent;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
      case AppButtonType.destructive:
        buttonBackgroundColor = backgroundColor ?? appColors.paletteRed100!;
        foregroundColor = AppColors.textIconsOnDark;
        disabledBackgroundColor = appColors.surfaceQuaternary!;
        disabledForegroundColor = appColors.textIconsTertiary!;
        break;
    }

    final buttonContent = isLoading
        ? SizedBox(
            width: textTheme.labelLarge!.fontSize! * 1.2,
            height: textTheme.labelLarge!.fontSize! * 1.2,
            child: CircularProgressIndicator(
              color: foregroundColor,
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonBackgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: borderSide ?? BorderSide.none,
      ),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      textStyle: textStyle ?? textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      elevation: 0,
      shadowColor: Colors.transparent,
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: buttonContent),
          )
        : ElevatedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: buttonContent);
  }
}
