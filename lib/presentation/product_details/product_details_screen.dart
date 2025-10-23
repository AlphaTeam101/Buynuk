import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/product_details/bloc/product_details_bloc.dart';
import 'package:e_commerce/presentation/product_details/widgets/product_details_content.dart';
import 'package:e_commerce/presentation/product_details/widgets/product_image_gallery.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state.status == ProductDetailsStatus.loading || state.status == ProductDetailsStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ProductDetailsStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          if (state.product == null) {
            return const Center(child: Text('Product not found'));
          }

          final product = state.product!;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  ProductImageGallery(product: product),
                  SliverPadding(
                    padding: const EdgeInsets.all(24.0),
                    sliver: ProductDetailsContent(product: product),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _AddToCartBar(product: product),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  final dynamic product; // Use dynamic to avoid import issues if Product entity changes
  const _AddToCartBar({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 16 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
              const SizedBox(height: 4),
              Text(
                '\$${product.price.toDouble().toStringAsFixed(2)}',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              text: 'Add to Cart',
              onPressed: () {
                context.read<CartBloc>().add(CartItemAdded(product));
                AppToast.show(
                  context: context,
                  title: 'Added to Cart',
                  message: '${product.title} has been added to your cart.',
                  type: ToastType.success,
                );
              },
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1.0, duration: 400.ms, curve: Curves.easeOutCubic);
  }
}
