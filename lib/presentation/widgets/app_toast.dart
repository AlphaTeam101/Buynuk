import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flash/flash.dart' show FlashBar, FlashBehavior;
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error }

class AppToast {
  // This class is not meant to be instantiated.
  AppToast._();

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required ToastType type,
  }) {
    final ThemeData theme = Theme.of(context);
    final AppColorsExtension appColors = theme.extension<AppColorsExtension>()!;
    final TextTheme textTheme = theme.textTheme;

    Color backgroundColor;
    Color iconColor;
    IconData iconData;

    switch (type) {
      case ToastType.success:
        backgroundColor = appColors.feedbackSuccess!;
        iconColor = Colors.white;
        iconData = Icons.check_circle_outline;
        break;
      case ToastType.error:
        backgroundColor = appColors.paletteRed100!;
        iconColor = Colors.white;
        iconData = Icons.error_outline;
        break;
    }

    context.showFlash<void>(
      barrierDismissible: true,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          behavior: FlashBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.all(16.0),
          clipBehavior: Clip.antiAlias,
          backgroundColor: backgroundColor,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(iconData, color: iconColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
