import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/presentation/product_details/bloc/product_details_bloc.dart';
import 'package:e_commerce/presentation/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductDetailsBloc>()..add(ProductDetailsStarted(productId)),
      child: const ProductDetailsScreen(),
    );
  }
}
