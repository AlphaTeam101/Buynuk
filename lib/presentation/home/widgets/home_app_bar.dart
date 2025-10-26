import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/notifications/notifications_screen.dart';
import 'package:e_commerce/presentation/search/search_page.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.surfacePrimary,
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.feedbackError,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Buynuk',
            style: textTheme.headlineMedium?.copyWith(
              color: AppColors.textIconsPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Hero(
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
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: AppColors.surfaceTertiary, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.textIconsSecondary, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'What are you looking for?',
                        style: textTheme.bodyLarge?.copyWith(color: AppColors.textIconsSecondary),
                      ),
                    ],
                  ),
                ),
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
              icon: Icon(Icons.notifications_none_outlined, color: AppColors.textIconsPrimary, size: 32),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.feedbackError,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 8,
                  minHeight: 8,
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
