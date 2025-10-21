import 'package:dio/dio.dart';

import '../models/token_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login(String email, String password);
  Future<UserModel> getProfile(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<TokenModel> login(String email, String password) async {
    final response = await _dio.post(
      'https://api.escuelajs.co/api/v1/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return TokenModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getProfile(String token) async {
    final response = await _dio.get(
      'https://api.escuelajs.co/api/v1/auth/profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return UserModel.fromJson(response.data);
  }
}
