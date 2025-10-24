
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.promotion:
        return Icons.campaign;
      case NotificationType.order:
        return Icons.local_shipping;
      case NotificationType.general:
        return Icons.notifications;
    }
  }

  Color _getIconColor(BuildContext context, NotificationType type) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    switch (type) {
      case NotificationType.promotion:
        return appColors.feedbackInfo!;
      case NotificationType.order:
        return appColors.feedbackSuccess!;
      case NotificationType.general:
        return appColors.textIconsSecondary!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead ? appColors.surfaceSecondary : appColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead ? Colors.transparent : appColors.brandSecondary!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getIconColor(context, notification.type).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconForType(notification.type),
              color: _getIconColor(context, notification.type),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: textTheme.bodyMedium?.copyWith(color: appColors.textIconsSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              margin: const EdgeInsets.only(left: 16),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
