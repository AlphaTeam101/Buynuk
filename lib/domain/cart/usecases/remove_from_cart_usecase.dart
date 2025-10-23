import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository _repository;

  RemoveFromCartUseCase(this._repository);

  Future<Either<String, void>> call(int productId) async {
    return await _repository.removeFromCart(productId);
  }
}
