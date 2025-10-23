import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  ClearCartUseCase(this._repository);

  Future<Either<String, void>> call() async {
    return await _repository.clearCart();
  }
}
