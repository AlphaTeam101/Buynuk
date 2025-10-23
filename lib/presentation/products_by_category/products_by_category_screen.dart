import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/domain/categories/entities/category.dart';
import 'package:e_commerce/presentation/home/widgets/product_grid.dart';
import 'package:e_commerce/presentation/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final Category category;

  const ProductsByCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsByCategoryBloc>()..add(FetchProductsByCategory(category.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
        ),
        body: BlocBuilder<ProductsByCategoryBloc, ProductsByCategoryState>(
          builder: (context, state) {
            if (state.status == ProductsByCategoryStatus.initial || state.status == ProductsByCategoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProductsByCategoryStatus.failure) {
              return Center(child: Text('Failed to fetch products: ${state.errorMessage}'));
            }
            return CustomScrollView(slivers: [ProductGrid(products: state.products)]);
          },
        ),
      ),
    );
  }
}
