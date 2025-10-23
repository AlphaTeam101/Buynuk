import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/cart/widgets/cart_item_card.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize _cartItems with the current state from the Bloc
    _cartItems = List.from(context.read<CartBloc>().state.items);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        debugPrint('CartScreen BlocConsumer listener. Status: ${state.status}, Total items: ${state.totalItems}');
        // Handle item removals and additions for AnimatedList
        if (state.status == CartStatus.loaded || state.status == CartStatus.success) {
          _updateAnimatedList(state.items);
        }
      },
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.items.isEmpty && _cartItems.isEmpty) {
          return const _EmptyCartBody();
        }

        return Stack(
          children: [
            AnimatedList(
              key: _animatedListKey,
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 150), // Added 24.0 top padding
              initialItemCount: _cartItems.length,
              itemBuilder: (context, index, animation) {
                final item = _cartItems[index];
                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1.0,
                  child: FadeTransition(
                    opacity: animation,
                    child: CartItemCard(key: ValueKey(item.product.id), item: item)
                        .animate()
                        .fade(duration: 500.ms, delay: (index * 100).ms)
                        .slideX(begin: -0.2, curve: Curves.easeOutCubic),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _CheckoutBar(state: state),
            ),
          ],
        );
      },
    );
  }

  void _updateAnimatedList(List<CartItem> newItems) {
    final oldItems = List<CartItem>.from(_cartItems);
    final animatedListState = _animatedListKey.currentState;

    // Find removed items
    for (int i = 0; i < oldItems.length; i++) {
      final oldItem = oldItems[i];
      if (!newItems.any((newItem) => newItem.product.id == oldItem.product.id)) {
        final removedIndex = _cartItems.indexOf(oldItem);
        if (removedIndex != -1) {
          animatedListState?.removeItem(
            removedIndex,
            (context, animation) => SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1.0,
              child: FadeTransition(
                opacity: animation,
                child: CartItemCard(key: ValueKey(oldItem.product.id), item: oldItem),
              ),
            ),
            duration: const Duration(milliseconds: 300),
          );
          _cartItems.removeAt(removedIndex);
        }
      }
    }

    // Find added items
    for (int i = 0; i < newItems.length; i++) {
      final newItem = newItems[i];
      if (!oldItems.any((oldItem) => oldItem.product.id == newItem.product.id)) {
        _cartItems.insert(i, newItem);
        animatedListState?.insertItem(i, duration: const Duration(milliseconds: 300));
      }
    }

    // Update existing items (important for quantity changes)
    for (int i = 0; i < newItems.length; i++) {
      final newItem = newItems[i];
      final existingIndex = _cartItems.indexWhere((item) => item.product.id == newItem.product.id);
      if (existingIndex != -1 && _cartItems[existingIndex] != newItem) {
        // Replace the item to trigger rebuild for quantity changes
        _cartItems[existingIndex] = newItem;
        // No need to call insert/remove for updates, just rebuilds the item
      }
    }

    // Ensure _cartItems matches newItems for any reordering or final state
    // This is a simplified approach; for complex reordering, a diff algorithm would be better.
    // For now, we'll just ensure the list reflects the new state after removals/additions.
    _cartItems = List.from(newItems);
  }
}

class _EmptyCartBody extends StatelessWidget {
  const _EmptyCartBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Replaced Lottie with a fallback Icon to prevent crashing
          Icon(Icons.shopping_cart_outlined, size: 120, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text('Your Cart is Empty', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Looks like you haven\'t added anything to your cart yet.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ).animate().fade(duration: 600.ms),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  final CartState state;
  const _CheckoutBar({required this.state});

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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  'Subtotal (${state.totalItems} items)',
                  key: ValueKey<int>(state.totalItems), // Key is crucial for AnimatedSwitcher
                  style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  '\$${state.subtotal.toStringAsFixed(2)}',
                  key: ValueKey<double>(state.subtotal), // Key is crucial for AnimatedSwitcher
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              text: 'Checkout',
              onPressed: () {
                // TODO: Navigate to checkout flow
              },
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1.0, duration: 400.ms, curve: Curves.easeOutCubic);
  }
}
