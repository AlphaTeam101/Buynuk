import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<Product> products;

  const SearchResultsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product, index: index);
        },
        childCount: products.length,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 16.0,
      ),
    );
  }
}
