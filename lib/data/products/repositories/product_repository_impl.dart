import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/products/entities/product.dart';
import '../../../domain/products/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, List<Product>>> getProducts({
    required int offset,
    required int limit,
  }) async {
    try {
      final productModels = await _remoteDataSource.getProducts(offset: offset, limit: limit);
      return Right(productModels);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> searchProducts({
    String? title,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final productModels = await _remoteDataSource.searchProducts(
        title: title,
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        offset: offset,
        limit: limit,
      );
      return Right(productModels);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Product>> getProductById(int id) async {
    try {
      final productModel = await _remoteDataSource.getProductById(id);
      return Right(productModel);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
