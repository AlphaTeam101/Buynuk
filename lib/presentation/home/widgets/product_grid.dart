import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.6, // Adjust this value to fit your card design
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final product = products[index];
            return ProductCard(product: product, index: index);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
