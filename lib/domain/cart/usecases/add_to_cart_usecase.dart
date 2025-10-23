import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';
import 'package:e_commerce/domain/products/entities/product.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<Either<String, void>> call(Product product) async {
    return await _repository.addToCart(product);
  }
}
