import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed Ali", // User's name
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.textIconsPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "+966773413440", // Phone number
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textIconsSecondary,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.surfaceSecondary,
            child: Icon(
              Icons.person,
              size: 30,
              color: AppColors.textIconsSecondary,
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: -0.2);
  }
}
