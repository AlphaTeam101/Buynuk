import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/auth/entities/user.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<String, User>> login(String email, String password) async {
    try {
      final tokenModel = await _remoteDataSource.login(email, password);
      await _localDataSource.saveTokens(tokenModel);
      final userModel = await _remoteDataSource.getProfile(tokenModel.accessToken);
      return Right(userModel);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left('Invalid credentials');
      }
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    }
  }

  @override
  Future<Either<String, User>> getProfile() async {
    try {
      final token = await _localDataSource.getAccessToken();
      if (token == null) {
        return Left('Not authenticated');
      }
      final user = await _remoteDataSource.getProfile(token);
      return Right(user);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An unknown error occurred');
    }
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearTokens();
  }
}
