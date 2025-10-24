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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.onSurface.withOpacity(0.8),
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (newValue) {
              context.read<ThemeBloc>().add(ThemeChanged(newValue));
              onChanged(newValue);
            },
            activeColor: AppColors.brandSecondary, // A vibrant color for the 'on' state
            trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.brandSecondary.withOpacity(0.5);
              }
              return null; // Use default track color
            }),
          ),
        ],
      ),
    );
  }
}
