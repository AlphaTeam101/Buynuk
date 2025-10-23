
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/orders/order_status.dart';
import 'package:e_commerce/presentation/orders/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_commerce/domain/categories/entities/category.dart';

// Dummy data for demonstration
class Order {
  final String id;
  final OrderStatus status;
  final DateTime date;
  final double total;
  final List<Product> items;
  final String paymentMethod;

  Order({
    required this.id,
    required this.status,
    required this.date,
    required this.total,
    required this.items,
    this.paymentMethod = 'APC',
  });
}

final List<Order> dummyOrders = [
  Order(
      id: '1',
      status: OrderStatus.tracking,
      date: DateTime(2025, 2, 24, 10, 0),
      total: 120.50,
      items: [
        const Product(
            id: 1,
            title: 'Classic Cotton T-Shirt',
            price: 25.00,
            description: 'A classic t-shirt made from 100% cotton.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/1/200'],
            slug: 'classic-cotton-t-shirt'),
        const Product(
            id: 2,
            title: 'Graphic Print T-Shirt',
            price: 35.50,
            description: 'A stylish t-shirt with a cool graphic print.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/2/200'],
            slug: 'graphic-print-t-shirt'),
      ]),
  Order(
      id: '2',
      status: OrderStatus.delivered,
      date: DateTime(2025, 2, 23, 15, 30),
      total: 65.00,
      items: [
        const Product(
            id: 3,
            title: 'V-Neck T-Shirt',
            price: 30.00,
            description: 'A soft and comfortable v-neck t-shirt.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/3/200'],
            slug: 'v-neck-t-shirt'),
      ]),
  Order(
      id: '3',
      status: OrderStatus.cancelled,
      date: DateTime(2025, 2, 22, 12, 0),
      total: 45.00,
      items: [
        const Product(
            id: 4,
            title: 'Long-Sleeve T-Shirt',
            price: 45.00,
            description: 'A warm and cozy long-sleeve t-shirt.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/4/200'],
            slug: 'long-sleeve-t-shirt'),
      ]),
  Order(
      id: '4',
      status: OrderStatus.pending,
      date: DateTime(2025, 2, 25, 9, 0),
      total: 250.00,
      items: [
        const Product(
            id: 1,
            title: 'Classic Cotton T-Shirt',
            price: 25.00,
            description: 'A classic t-shirt made from 100% cotton.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/1/200'],
            slug: 'classic-cotton-t-shirt'),
        const Product(
            id: 2,
            title: 'Graphic Print T-Shirt',
            price: 35.50,
            description: 'A stylish t-shirt with a cool graphic print.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/2/200'],
            slug: 'graphic-print-t-shirt'),
        const Product(
            id: 3,
            title: 'V-Neck T-Shirt',
            price: 30.00,
            description: 'A soft and comfortable v-neck t-shirt.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/3/200'],
            slug: 'v-neck-t-shirt'),
        const Product(
            id: 4,
            title: 'Long-Sleeve T-Shirt',
            price: 45.00,
            description: 'A warm and cozy long-sleeve t-shirt.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/4/200'],
            slug: 'long-sleeve-t-shirt'),
        const Product(
            id: 1,
            title: 'Classic Cotton T-Shirt',
            price: 25.00,
            description: 'A classic t-shirt made from 100% cotton.',
            category: Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
            images: ['https://picsum.photos/seed/1/200'],
            slug: 'classic-cotton-t-shirt'),
      ]),
];

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: dummyOrders.length,
        itemBuilder: (context, index) {
          final order = dummyOrders[index];
          return OrderCard(order: order).animate().fade(duration: 500.ms).slideX(begin: -0.3, curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}
