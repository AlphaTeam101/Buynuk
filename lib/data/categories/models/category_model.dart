import 'package:hive/hive.dart';
import '../../../domain/categories/entities/category.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2) // Unique ID for Hive
class CategoryModel extends Category {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String image;

  @HiveField(3)
  @override
  final String slug;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  }) : super(id: id, name: name, image: image, slug: slug);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      slug: json['slug'],
    );
  }
}