import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/categories/entities/category.dart';
import '../../../domain/categories/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      final categoryModels = await _remoteDataSource.getCategories();
      return Right(categoryModels);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
