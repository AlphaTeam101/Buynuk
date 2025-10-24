
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 20),
          const Text(
            'Estimated Delivery',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            '10:00 AM - 12:00 PM',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 40),
          const _OrderDetails(),
          const Divider(height: 40),
          const _ProductList(),
          const Divider(height: 40),
          const _DriverInfo(),
          const Divider(height: 40),
          const _OrderStatusTimeline(),
        ].animate(interval: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeOutCubic),
      ),
    );
  }
}

class _OrderDetails extends StatelessWidget {
  const _OrderDetails();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order ID:', style: TextStyle(color: Colors.grey)),
            Text('#123456789', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Price:', style: TextStyle(color: Colors.grey)),
            Text('\$150.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ],
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _ProductItem(
          imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1099&q=80',
          name: 'Classic Watch',
          quantity: 1,
        ),
        SizedBox(height: 16),
        _ProductItem(
          imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
          name: 'Red Sports Shoe',
          quantity: 1,
        ),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int quantity;

  const _ProductItem({
    required this.imageUrl,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Quantity: $quantity', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

class _DriverInfo extends StatelessWidget {
  const _DriverInfo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('John Doe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Delivery Driver', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            final Uri launchUri = Uri(
              scheme: 'tel',
              path: '01015497697',
            );
            await launchUrl(launchUri);
          },
          icon: const Icon(Icons.call, color: Colors.green),
          iconSize: 28,
        ),
      ],
    );
  }
}

class _OrderStatusTimeline extends StatelessWidget {
  const _OrderStatusTimeline();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        _TimelineTile(title: 'Order Confirmed', time: '08:00 AM', isCompleted: true),
        _TimelineTile(title: 'Shipped', time: '08:30 AM', isCompleted: true),
        _TimelineTile(title: 'Out for Delivery', time: '09:30 AM', isCompleted: true, isLast: false),
        _TimelineTile(title: 'Delivered', time: 'Est. 11:00 AM', isCompleted: false, isLast: true),
      ],
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool isLast;

  const _TimelineTile({
    required this.title,
    required this.time,
    this.isCompleted = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? appColors.feedbackSuccess : Colors.grey[300],
                ),
                child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
