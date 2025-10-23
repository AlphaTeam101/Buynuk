import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          // The animation delay is now based on the product's index in the overall list
          return ProductCard(product: product, index: index);
        },
        childCount: products.length,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 16.0,
      ),
    );
  }
}