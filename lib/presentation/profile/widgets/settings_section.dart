import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.textIconsSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                return Column(
                  children: [
                    items[index],
                    if (index < items.length - 1)
                      const Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: AppColors.surfaceTertiary,
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
