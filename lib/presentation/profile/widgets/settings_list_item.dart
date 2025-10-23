import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;
  final Color? iconColor;

  const SettingsListItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? appColors.surfaceSecondary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: textTheme.bodyLarge?.copyWith(
                color: labelColor ?? appColors.surfaceSecondary,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: appColors.surfaceSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
