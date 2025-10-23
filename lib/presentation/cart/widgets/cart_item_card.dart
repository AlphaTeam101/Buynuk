import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Duration for exit animation
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.5)).animate( // Slide up
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _removeItem() async {
    await _animationController.forward(); // Start exit animation
    if (mounted) {
      context.read<CartBloc>().add(CartItemRemoved(widget.item.product.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Slidable(
          // Removed key: ValueKey(widget.item.product.id) from Slidable to avoid GlobalKey conflict
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  _removeItem();
                },
                backgroundColor: appColors.paletteRed100!,
                foregroundColor: Colors.white,
                icon: Icons.delete_outline,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12.0),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 0,
            color: appColors.surfaceSecondary,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.item.product.images.isNotEmpty ? widget.item.product.images.first : '',
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
                        Text(widget.item.product.title, style: textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.item.product.price.toDouble().toStringAsFixed(2)}',
                          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  _QuantityControls(item: widget.item),
                ],
              ),
            ),
          ),
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
          icon: const Icon(Icons.remove_circle_outline),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            item.quantity.toString(),
            key: ValueKey<String>('${item.product.id}-${item.quantity}'), // Made key unique
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          onPressed: () {
            cartBloc.add(CartItemQuantityUpdated(item.product.id, item.quantity + 1));
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
