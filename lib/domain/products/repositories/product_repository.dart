import 'package:fpdart/fpdart.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<String, List<Product>>> getProducts({
    required int offset,
    required int limit,
    String? category,
  });

  Future<Either<String, List<Product>>> searchProducts({
    String? title,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int offset = 0,
    int limit = 10,
  });

  Future<Either<String, Product>> getProductById(int id);
}
