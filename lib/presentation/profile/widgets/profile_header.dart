import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John", // User's name
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: theme.colorScheme.onSurface, // Corrected
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "+9647734123440", // Phone number
                  style: textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7), // Corrected
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: appColors.surfaceSecondary, // This is defined in AppColorsExtension
            child: Icon(
              Icons.person,
              size: 30,
              color: appColors.textIconsSecondary, // Corrected to use an existing text/icon color
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: -0.2);
  }
}
