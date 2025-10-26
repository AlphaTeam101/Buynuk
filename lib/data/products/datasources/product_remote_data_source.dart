import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    required int offset,
    required int limit,
    String? category,
  });

  Future<List<ProductModel>> searchProducts({
    String? title,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int offset = 0,
    int limit = 10,
  });

  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts({
    required int offset,
    required int limit,
    String? category,
  }) async {
    final queryParameters = <String, dynamic>{
      'offset': offset,
      'limit': limit,
    };

    if (category != null && category.isNotEmpty) {
      // The API uses categoryId, so we need to find the ID for the category name.
      // This is a simplified approach. A real app might have a better way to get category IDs.
      final categoriesResponse = await _dio.get('https://api.escuelajs.co/api/v1/categories');
      final categories = categoriesResponse.data as List;
      final categoryMap = { for (var e in categories) e['name'] : e['id' ] };
      if (categoryMap.containsKey(category)) {
        queryParameters['categoryId'] = categoryMap[category];
      }
    }

    final response = await _dio.get(
      'https://api.escuelajs.co/api/v1/products',
      queryParameters: queryParameters,
    );
    final data = response.data as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> searchProducts({
    String? title,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int offset = 0,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'offset': offset,
      'limit': limit,
    };

    if (title != null && title.isNotEmpty) {
      queryParameters['title'] = title;
    }
    if (categoryId != null) {
      queryParameters['categoryId'] = categoryId;
    }
    if (minPrice != null) {
      queryParameters['price_min'] = minPrice;
    }
    if (maxPrice != null) {
      queryParameters['price_max'] = maxPrice;
    }

    final response = await _dio.get(
      'https://api.escuelajs.co/api/v1/products',
      queryParameters: queryParameters,
    );
    final data = response.data as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await _dio.get('https://api.escuelajs.co/api/v1/products/$id');
    return ProductModel.fromJson(response.data);
  }
}
