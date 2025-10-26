import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/product_details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index; // To calculate animation delay

  const ProductCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(productId: product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: AppColors.surfaceTertiary, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'product_card_${product.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: Image.network(
                      product.images.isNotEmpty ? product.images.first : 'https://placehold.co/600x400',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 150,
                          color: AppColors.surfaceTertiary,
                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        color: AppColors.surfaceTertiary,
                        child: const Center(child: Icon(Icons.error_outline, color: AppColors.textIconsSecondary)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.feedbackError,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '-35%', // Static discount
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textIconsOnDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: AppColors.textIconsPrimary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.textIconsPrimary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textIconsPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '300.00 SAR', // Static price
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.feedbackError,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '360.00 SAR', // Static original price
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textIconsSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star_half, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '(44)', // Static review count
                          style: textTheme.bodySmall?.copyWith(color: AppColors.textIconsSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<CartBloc>().add(CartItemAdded(product));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart'),
                    backgroundColor: AppColors.feedbackError,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const BoxDecoration(
                  color: AppColors.textIconsPrimary, // Black bar
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
                ),
                child: const Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(color: AppColors.textIconsOnDark, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.forward(from: 0.0))
        .fade(duration: 500.ms, delay: (index * 50).ms, curve: Curves.easeOut)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}
