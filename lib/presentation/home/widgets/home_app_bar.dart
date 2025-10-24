import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/notifications/notifications_screen.dart';
import 'package:e_commerce/presentation/search/search_page.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: 16.0,
      title: Hero(
        tag: 'search_bar',
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: appColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: appColors.textIconsTertiary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Search products...',
                    style: textTheme.bodyLarge?.copyWith(color: appColors.textIconsTertiary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen()));
              },
              icon: Icon(Icons.notifications_outlined, color: theme.colorScheme.onSurface, size: 28),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8), // Give some space from the edge
      ],
    );
  }
}
