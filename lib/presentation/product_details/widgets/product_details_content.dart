import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductDetailsContent extends StatelessWidget {
  final Product product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Text(
            product.category.name.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold),
          )
              .animate()
              .fade(duration: 500.ms, delay: 100.ms)
              .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: textTheme.headlineLarge,
          )
              .animate()
              .fade(duration: 500.ms, delay: 200.ms)
              .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          const SizedBox(height: 24),
          Text(
            'Description',
            style: textTheme.titleMedium,
          )
              .animate()
              .fade(duration: 500.ms, delay: 300.ms)
              .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
          )
              .animate()
              .fade(duration: 500.ms, delay: 400.ms)
              .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          // Add some extra space at the bottom to ensure content doesn't hide behind the FAB
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
