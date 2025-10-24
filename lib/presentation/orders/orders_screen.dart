
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/domain/products/repositories/product_repository.dart';
import 'package:e_commerce/presentation/orders/order_status.dart';
import 'package:e_commerce/presentation/orders/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';

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

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final ProductRepository _productRepository;
  List<Order> _orders = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _productRepository = GetIt.instance<ProductRepository>();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final result = await _productRepository.getProducts(offset: 0, limit: 10);

    result.fold(
      (error) {
        setState(() {
          _error = error;
          _isLoading = false;
        });
      },
      (products) {
        if (products.isNotEmpty) {
          // Create dummy orders from the fetched products
          final orders = [
            if (products.length >= 2)
              Order(
                id: '1',
                status: OrderStatus.tracking,
                date: DateTime(2025, 2, 24, 10, 0),
                total: products.take(2).fold(0, (sum, item) => sum + item.price),
                items: products.take(2).toList(),
              ),
            if (products.length >= 4)
              Order(
                id: '2',
                status: OrderStatus.delivered,
                date: DateTime(2025, 2, 23, 15, 30),
                total: products[2].price,
                items: [products[2]],
              ),
            if (products.length >= 4)
              Order(
                id: '3',
                status: OrderStatus.cancelled,
                date: DateTime(2025, 2, 22, 12, 0),
                total: products[3].price,
                items: [products[3]],
              ),
            if (products.length > 4)
              Order(
                id: '4',
                status: OrderStatus.pending,
                date: DateTime(2025, 2, 25, 9, 0),
                total: products.skip(4).fold(0, (sum, item) => sum + item.price),
                items: products.skip(4).toList(),
              ),
          ];
          setState(() {
            _orders = orders;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Text('An error occurred: $_error'),
      );
    }

    if (_orders.isEmpty) {
      return const Center(
        child: Text('You have no past orders.'),
      );
    }

    return ListView.builder(
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return OrderCard(order: order).animate().fade(duration: 500.ms).slideX(begin: -0.3, curve: Curves.easeOutCubic);
      },
    );
  }
}
