import 'package:fpdart/fpdart.dart';

import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Either<String, List<Category>>> call() async {
    return await _repository.getCategories();
  }
}
