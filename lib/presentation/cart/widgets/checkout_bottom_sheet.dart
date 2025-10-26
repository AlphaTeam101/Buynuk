import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    final state = context.watch<CartBloc>().state;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: appColors.surfaceQuaternary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          _SummaryRow(label: 'Subtotal', value: state.subtotal),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Shipping', value: 0), // Placeholder
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price', style: textTheme.titleLarge),
              Text(
                '${state.subtotal.toStringAsFixed(2)} SAR',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Complete Purchase',
            onPressed: state.items.isNotEmpty ? () {} : null,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
        Text('${value.toStringAsFixed(2)} SAR', style: textTheme.bodyLarge),
      ],
    );
  }
}
