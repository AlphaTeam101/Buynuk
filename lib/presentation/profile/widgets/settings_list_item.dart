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
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? colorScheme.onSurface.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: textTheme.bodyLarge?.copyWith(
                color: labelColor ?? colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurface.withOpacity(0.6),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
