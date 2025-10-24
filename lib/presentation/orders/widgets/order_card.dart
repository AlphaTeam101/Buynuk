
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/orders/order_status.dart';
import 'package:e_commerce/presentation/orders/orders_screen.dart';
import 'package:e_commerce/presentation/orders/track_order_screen.dart';
import 'package:e_commerce/presentation/orders/widgets/order_item_row.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  Color _getStatusColor(BuildContext context, OrderStatus status) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    switch (status) {
      case OrderStatus.delivered:
        return appColors.feedbackSuccess!;
      case OrderStatus.cancelled:
        return Theme.of(context).colorScheme.error;
      case OrderStatus.pending:
        return appColors.feedbackWarning!;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 8,
              decoration: BoxDecoration(
                color: _getStatusColor(context, order.status),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _OrderCardHeader(order: order),
                    const Divider(height: 32),
                    _OrderCardBody(order: order),
                    if (order.items.length > 3) ...[
                      const SizedBox(height: 16),
                      _OrderCardFooter(order: order),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCardHeader extends StatelessWidget {
  final Order order;

  const _OrderCardHeader({required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${order.id}', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(DateFormat('MMM d, yyyy').format(order.date), style: textTheme.bodyMedium?.copyWith(color: appColors.textIconsSecondary)),
          ],
        ),
        Text('\$${order.total.toStringAsFixed(2)}', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _OrderCardBody extends StatelessWidget {
  final Order order;

  const _OrderCardBody({required this.order});

  @override
  Widget build(BuildContext context) {
    final itemsToShow = order.items.take(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...itemsToShow.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: OrderItemRow(item: item),
            )),
        _buildStatusWidget(context),
      ],
    );
  }

  Widget _buildStatusWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    switch (order.status) {
      case OrderStatus.tracking:
        return Align(
          alignment: Alignment.centerRight,
          child: AppButton(
            text: 'Track Order',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TrackOrderScreen()));
            },
            buttonType: AppButtonType.primary,
            leadingIcon: const Icon(Icons.local_shipping, size: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            textStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      case OrderStatus.delivered:
        return _StatusChip(icon: Icons.check_circle, text: 'Delivered', color: appColors.feedbackSuccess!);
      case OrderStatus.cancelled:
        return _StatusChip(icon: Icons.cancel, text: 'Cancelled', color: Theme.of(context).colorScheme.error);
      case OrderStatus.pending:
        return _StatusChip(icon: Icons.hourglass_top, text: 'Pending', color: appColors.feedbackWarning!);
    }
  }
}

class _OrderCardFooter extends StatelessWidget {
  final Order order;

  const _OrderCardFooter({required this.order});

  @override
  Widget build(BuildContext context) {
    final remainingItems = order.items.length - 3;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('+ $remainingItems more items', style: textTheme.bodySmall?.copyWith(color: Theme.of(context).extension<AppColorsExtension>()!.textIconsSecondary)),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _StatusChip({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
