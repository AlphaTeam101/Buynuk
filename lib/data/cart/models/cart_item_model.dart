import 'package:hive/hive.dart';
import 'package:e_commerce/data/products/models/product_model.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final ProductModel product;

  @HiveField(1)
  int quantity;

  CartItemModel({required this.product, required this.quantity});
}
