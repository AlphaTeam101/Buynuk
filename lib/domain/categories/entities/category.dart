import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String image;
  final String slug;

  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  @override
  List<Object?> get props => [id, name, image, slug];
}
