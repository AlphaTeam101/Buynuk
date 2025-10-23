import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageGallery extends StatefulWidget {
  final Product product;

  const ProductImageGallery({super.key, required this.product});

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.width, // Make it a square
      pinned: true,
      backgroundColor: appColors.surfaceSecondary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-${widget.product.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.product.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.product.images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 50),
                    ),
                  );
                },
              ),
              if (widget.product.images.length > 1)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.product.images.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: theme.primaryColor,
                        dotColor: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
