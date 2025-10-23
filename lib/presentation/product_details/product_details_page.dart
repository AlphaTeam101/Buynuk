import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/presentation/product_details/bloc/product_details_bloc.dart';
import 'package:e_commerce/presentation/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart'; // Import CartBloc

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // Get the existing CartBloc instance from the ancestor BlocProvider
    final CartBloc cartBloc = context.read<CartBloc>();

    return MultiBlocProvider( // Use MultiBlocProvider to provide multiple blocs
      providers: [
        BlocProvider<ProductDetailsBloc>(
          create: (context) => getIt<ProductDetailsBloc>()..add(ProductDetailsStarted(productId)),
        ),
        BlocProvider<CartBloc>.value( // Provide the existing CartBloc instance
          value: cartBloc,
        ),
      ],
      child: const ProductDetailsScreen(),
    );
  }
}
