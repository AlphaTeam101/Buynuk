import 'package:e_commerce/domain/categories/entities/category.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsByCategoryScreen(category: category),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 150, // Increased width for a better look
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                category.image,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported, color: AppColors.textIconsSecondary, size: 40),
                  );
                },
              ),
              Center(
                child: Text(
                  category.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textIconsOnDark,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
