import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceCallout extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ServiceCallout({super.key, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.textIconsPrimary, // Dark icon background
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textIconsOnDark, size: 24),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textIconsPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textIconsSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
