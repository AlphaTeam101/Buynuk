import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0,
      color: AppColors.surfaceSecondary,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.product.images.isNotEmpty ? item.product.images.first : '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(width: 80, height: 80, child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: textTheme.titleMedium?.copyWith(color: AppColors.textIconsPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item.product.price.toDouble().toStringAsFixed(2)} SAR',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textIconsPrimary,
                    ),
                  ),
                ],
              ),
            ),
            _QuantityControls(item: item),
          ],
        ),
      ),
    );
  }
}

class _QuantityControls extends StatelessWidget {
  final CartItem item;

  const _QuantityControls({required this.item});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (item.quantity > 1) {
              cartBloc.add(CartItemQuantityUpdated(item.product.id, item.quantity - 1));
            } else {
              cartBloc.add(CartItemRemoved(item.product.id));
            }
          },
          icon: const Icon(Icons.remove_circle_outline, color: AppColors.textIconsSecondary),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            item.quantity.toString(),
            key: ValueKey<int>(item.quantity),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textIconsPrimary),
          ),
        ),
        IconButton(
          onPressed: () {
            cartBloc.add(CartItemQuantityUpdated(item.product.id, item.quantity + 1));
          },
          icon: const Icon(Icons.add_circle_outline, color: AppColors.textIconsSecondary),
        ),
      ],
    );
  }
}
