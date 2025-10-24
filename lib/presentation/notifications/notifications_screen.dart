
import 'package:e_commerce/presentation/notifications/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

enum NotificationType { promotion, order, general }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final NotificationType type;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    this.isRead = false,
  });
}

final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    id: '1',
    title: 'Summer Sale is Here!',
    message: 'Get up to 50% off on all summer collection items. Don\'t miss out!',
    date: DateTime.now(),
    type: NotificationType.promotion,
  ),
  NotificationModel(
    id: '2',
    title: 'Your Order has been Shipped!',
    message: 'Your order #12345 has been shipped and is on its way to you.',
    date: DateTime.now().subtract(const Duration(hours: 2)),
    type: NotificationType.order,
    isRead: true,
  ),
  NotificationModel(
    id: '3',
    title: 'New Login Alert',
    message: 'A new device has logged into your account. If this was not you, please secure your account.',
    date: DateTime.now().subtract(const Duration(days: 1)),
    type: NotificationType.general,
  ),
  NotificationModel(
    id: '4',
    title: 'Flash Deal!',
    message: 'Limited time offer: Buy one get one free on selected items.',
    date: DateTime.now().subtract(const Duration(days: 2)),
    type: NotificationType.promotion,
    isRead: true,
  ),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationModel> _notifications;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _notifications = List.from(dummyNotifications);
  }

  void _removeNotification(String id) {
    final index = _notifications.indexWhere((notification) => notification.id == id);
    if (index != -1) {
      final removedItem = _notifications.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: NotificationCard(notification: removedItem),
          ),
        ),
        duration: const Duration(milliseconds: 300),
      );
      setState(() {}); // To rebuild and regroup if a whole group is removed
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = _groupNotifications(_notifications);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: groupedNotifications.length,
        itemBuilder: (context, index, animation) {
          final group = groupedNotifications[index];
          return FadeTransition(
            opacity: animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    group.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ...group.notifications.map((notification) {
                  return Slidable(
                    key: ValueKey(notification.id),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      extentRatio: 0.25,
                      dismissible: DismissiblePane(onDismissed: () {
                        HapticFeedback.mediumImpact();
                        _removeNotification(notification.id);
                      }),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SlidableAction(
                            onPressed: (context) {
                              HapticFeedback.mediumImpact();
                              _removeNotification(notification.id);
                            },
                            backgroundColor: Theme.of(context).colorScheme.error,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    child: NotificationCard(notification: notification),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  List<_NotificationGroup> _groupNotifications(List<NotificationModel> notifications) {
    final Map<String, List<NotificationModel>> grouped = {};

    for (final notification in notifications) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final notificationDate = DateTime(notification.date.year, notification.date.month, notification.date.day);

      String groupTitle;
      if (notificationDate == today) {
        groupTitle = 'Today';
      } else if (notificationDate == yesterday) {
        groupTitle = 'Yesterday';
      } else {
        groupTitle = DateFormat('MMMM d, yyyy').format(notification.date);
      }

      if (grouped[groupTitle] == null) {
        grouped[groupTitle] = [];
      }
      grouped[groupTitle]!.add(notification);
    }

    return grouped.entries.map((entry) => _NotificationGroup(title: entry.key, notifications: entry.value)).where((group) => group.notifications.isNotEmpty).toList();
  }
}

class _NotificationGroup {
  final String title;
  final List<NotificationModel> notifications;

  _NotificationGroup({required this.title, required this.notifications});
}
