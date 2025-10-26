import 'package:fpdart/fpdart.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<String, List<Product>>> call({
    required int offset,
    required int limit,
    String? category,
  }) async {
    return await _repository.getProducts(offset: offset, limit: limit, category: category);
  }
}
