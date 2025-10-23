import 'package:e_commerce/domain/categories/entities/category.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/products_by_category/products_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox(height: 100); // Return empty space if no categories
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _CategoryCard(category: category),
          );
        },
      ),
    ).animate().fade(duration: 500.ms).slideX(begin: -0.5, curve: Curves.easeOutCubic);
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsByCategoryScreen(category: category),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: appColors.surfaceSecondary,
            child: ClipOval(
              child: Image.network(
                category.image,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
                errorBuilder: (context, error, stackTrace) {
                  // If the image fails to load (like with pravatar.cc), show a fallback icon.
                  return const Icon(Icons.category_outlined, color: Colors.grey, size: 32);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: textTheme.bodyMedium?.copyWith(color: appColors.textIconsSecondary),
          ),
        ],
      ),
    );
  }
}
