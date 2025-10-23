import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';

class UpdateQuantityUseCase {
  final CartRepository _repository;

  UpdateQuantityUseCase(this._repository);

  Future<Either<String, void>> call(int productId, int quantity) async {
    return await _repository.updateQuantity(productId, quantity);
  }
}
