import 'package:fpdart/fpdart.dart';

import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}
