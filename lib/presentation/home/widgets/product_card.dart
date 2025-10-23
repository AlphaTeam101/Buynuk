import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/product_details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index; // To calculate animation delay

  const ProductCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(productId: product.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'product-${product.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                product.images.isNotEmpty ? product.images.first : 'https://placehold.co/600x400', // Use first image or a placeholder
                fit: BoxFit.cover,
                // Add error and loading builders for a better UX
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return AspectRatio(
                    aspectRatio: 1, // Or the aspect ratio of your images
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const AspectRatio(
                  aspectRatio: 1,
                  child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              product.title,
              style: textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '\$${product.price.toDouble().toStringAsFixed(2)}',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.forward(from: 0.0))
        .fade(duration: 500.ms, delay: (index * 50).ms, curve: Curves.easeOut)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}
