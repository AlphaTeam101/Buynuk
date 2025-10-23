import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';

import '../../design_system/app_colors.dart';

class SettingsToggleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const SettingsToggleItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textIconsQuaternary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textIconsPrimaryDark78,
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: appColors.surfaceSecondary,
          ),
        ],
      ),
    );
  }
}
