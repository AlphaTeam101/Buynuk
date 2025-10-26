import 'package:e_commerce/logic/theme/theme_bloc.dart';
import 'package:e_commerce/logic/theme/theme_event.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textIconsSecondary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textIconsPrimary,
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (newValue) {
              context.read<ThemeBloc>().add(ThemeChanged(newValue));
              onChanged(newValue);
            },
            activeColor: AppColors.feedbackError, // Use red for the 'on' state
            trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.feedbackError.withOpacity(0.5);
              }
              return null; // Use default track color
            }),
          ),
        ],
      ),
    );
  }
}
