import 'package:e_commerce/data/cart/datasources/cart_local_data_source.dart';
import 'package:e_commerce/data/cart/models/cart_item_model.dart';
import 'package:e_commerce/data/products/models/product_model.dart';
import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:fpdart/fpdart.dart';
import 'package:e_commerce/data/categories/models/category_model.dart';
import 'package:e_commerce/domain/categories/entities/category.dart';


class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, void>> addToCart(Product product) async {
    try {
      final existingItems = _localDataSource.getCartItems();
      final existingItem = existingItems.cast<CartItemModel?>().firstWhere(
            (item) => item?.product.id == product.id,
            orElse: () => null,
          );

      if (existingItem != null) {
        // If item exists, just increase quantity
        final newQuantity = existingItem.quantity + 1;
        return await updateQuantity(product.id, newQuantity);
      } else {
        // If item doesn't exist, add it with quantity 1
        // We must convert the domain Product entity to a concrete ProductModel for storage
        final productModel = ProductModel(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: CategoryModel(id: product.category.id, name: product.category.name, image: product.category.image, slug: product.category.slug),
          images: product.images,
          slug: product.slug,
        );
        final newItem = CartItemModel(product: productModel, quantity: 1);
        await _localDataSource.addToCart(newItem);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> clearCart() async {
    try {
      await _localDataSource.clearCart();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CartItem>>> getCartItems() async {
    try {
      final items = _localDataSource.getCartItems();
      final domainItems = items.map((model) => CartItem(
        product: Product(
          id: model.product.id,
          title: model.product.title,
          price: model.product.price,
          description: model.product.description,
          category: Category(
            id: model.product.category.id,
            name: model.product.category.name,
            image: model.product.category.image,
            slug: model.product.category.slug,
          ),
          images: model.product.images,
          slug: model.product.slug,
        ),
        quantity: model.quantity,
      )).toList();
      return Right(domainItems);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> removeFromCart(int productId) async {
    try {
      await _localDataSource.removeFromCart(productId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateQuantity(int productId, int quantity) async {
    try {
      if (quantity <= 0) {
        // If quantity is zero or less, remove the item
        return await removeFromCart(productId);
      } else {
        await _localDataSource.updateQuantity(productId, quantity);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
