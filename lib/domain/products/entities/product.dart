import 'package:equatable/equatable.dart';

import '../../categories/entities/category.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final List<String> images;
  final String slug;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.slug,
  });

  @override
  List<Object?> get props => [id, title, price, description, category, images, slug];
}
