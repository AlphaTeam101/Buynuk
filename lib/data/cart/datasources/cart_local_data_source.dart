import 'package:hive/hive.dart';
import 'package:e_commerce/data/cart/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> init();
  List<CartItemModel> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _boxName = 'cart';

  @override
  Future<void> init() async {
    // The box will be opened in main.dart to ensure it's ready before the app runs
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<CartItemModel>(_boxName);
    }
  }

  @override
  List<CartItemModel> getCartItems() {
    final box = Hive.box<CartItemModel>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final box = Hive.box<CartItemModel>(_boxName);
    // Hive uses a key-value system. We'll use the product ID as the key.
    await box.put(item.product.id, item);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final box = Hive.box<CartItemModel>(_boxName);
    await box.delete(productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final box = Hive.box<CartItemModel>(_boxName);
    final item = box.get(productId);
    if (item != null) {
      final updatedItem = CartItemModel(product: item.product, quantity: quantity);
      await box.put(productId, updatedItem);
    }
  }

  @override
  Future<void> clearCart() async {
    final box = Hive.box<CartItemModel>(_boxName);
    await box.clear();
  }
}
