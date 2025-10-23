import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/domain/products/entities/product.dart';

abstract class CartRepository {
  Future<Either<String, List<CartItem>>> getCartItems();
  Future<Either<String, void>> addToCart(Product product);
  Future<Either<String, void>> removeFromCart(int productId);
  Future<Either<String, void>> updateQuantity(int productId, int quantity);
  Future<Either<String, void>> clearCart();
}
