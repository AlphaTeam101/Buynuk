
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:flutter/material.dart';

class OrderItemRow extends StatelessWidget {
  final Product item;

  const OrderItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.images.first,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 4),
              Text(item.category.name, style: textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text('\$${item.price.toStringAsFixed(2)}', style: textTheme.titleMedium),
      ],
    );
  }
}
