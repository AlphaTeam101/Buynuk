import 'package:fpdart/fpdart.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;

  GetProductByIdUseCase(this._repository);

  Future<Either<String, Product>> call(int id) async {
    return await _repository.getProductById(id);
  }
}
