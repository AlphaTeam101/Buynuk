import 'package:e_commerce/data/categories/models/category_model.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends Product {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final double price;

  @HiveField(3)
  @override
  final String description;

  @HiveField(4)
  @override
  final CategoryModel category;

  @HiveField(5)
  @override
  final List<String> images;

  @HiveField(6)
  @override
  final String slug;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.slug,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          images: images,
          slug: slug,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      images: List<String>.from(json['images']),
      slug: json['slug'],
    );
  }
}
