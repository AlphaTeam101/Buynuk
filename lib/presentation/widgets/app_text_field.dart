import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.prefixIcon,
    this.validator,
  });

  final TextEditingController? controller;
  final String? labelText;
  final IconData? prefixIcon;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppColorsExtension appColors = theme.extension<AppColorsExtension>()!;
    final TextTheme textTheme = theme.textTheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textTheme.bodyMedium?.copyWith(color: appColors.textIconsTertiary),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: appColors.textIconsTertiary) : null,
        
        // Border Styles
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: appColors.surfaceQuaternary!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
