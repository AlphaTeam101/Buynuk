import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, price, imageUrl];
}
