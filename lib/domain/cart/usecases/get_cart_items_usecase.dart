import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository _repository;

  GetCartItemsUseCase(this._repository);

  Future<Either<String, List<CartItem>>> call() async {
    return await _repository.getCartItems();
  }
}
