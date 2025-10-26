import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart' hide CarouselController;

class PromoCarousel extends StatelessWidget {
  final List<Product> products;
  const PromoCarousel({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> promoBanners = products.map((product) {
      return Builder(
        builder: (BuildContext context) {
          return _buildPromoBanner(context, product);
        },
      );
    }).toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0, // Increased height for better image visibility
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85, // Slightly larger viewport
      ),
      items: promoBanners,
    );
  }

  Widget _buildPromoBanner(BuildContext context, Product product) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (product.images.isNotEmpty)
              Image.network(
                product.images.first,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: textTheme.headlineSmall?.copyWith(
                      color: AppColors.textIconsOnDark,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Shop Now',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.textIconsOnDark.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
