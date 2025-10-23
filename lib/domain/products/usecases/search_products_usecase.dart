import 'package:fpdart/fpdart.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Either<String, List<Product>>> call({
    String? title,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int offset = 0,
    int limit = 10,
  }) async {
    return await _repository.searchProducts(
      title: title,
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      offset: offset,
      limit: limit,
    );
  }
}
