import 'package:dio/dio.dart';

import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio _dio;

  CategoryRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('https://api.escuelajs.co/api/v1/categories');
    final data = response.data as List;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
