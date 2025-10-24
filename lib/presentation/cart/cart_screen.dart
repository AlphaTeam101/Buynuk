import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/cart/widgets/cart_item_card.dart';
import 'package:e_commerce/presentation/checkout/checkout_screen.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.status == CartStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.items.isEmpty) {
              return const _EmptyCartBody();
            }

            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 150.0),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Slidable(
                      key: ValueKey(item.product.id),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        extentRatio: 0.25,
                        dismissible: DismissiblePane(onDismissed: () {
                          context.read<CartBloc>().add(CartItemRemoved(item.product.id));
                        }),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            child: SlidableAction(
                              onPressed: (context) {
                                context.read<CartBloc>().add(CartItemRemoved(item.product.id));
                              },
                              backgroundColor: Theme.of(context).colorScheme.error,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ),
                      child: CartItemCard(item: item),
                    ).animate().fade(duration: 500.ms, delay: (index * 100).ms).slideX(begin: -0.2, curve: Curves.easeOutCubic);
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
        ),
      ),
    );
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
                  key: ValueKey<int>(state.totalItems),
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
                  key: ValueKey<double>(state.subtotal),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen()));
              },
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1.0, duration: 400.ms, curve: Curves.easeOutCubic);
  }
}
