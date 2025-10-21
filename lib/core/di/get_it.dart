import 'package:dio/dio.dart';
import 'package:e_commerce/data/auth/datasources/auth_local_data_source.dart';
import 'package:e_commerce/data/auth/datasources/auth_remote_data_source.dart';
import 'package:e_commerce/data/auth/repositories/auth_repository_impl.dart';
import 'package:e_commerce/domain/auth/repositories/auth_repository.dart';
import 'package:e_commerce/domain/auth/usecases/login_usecase.dart';
import 'package:e_commerce/presentation/auth/bloc/login_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // BLoC
  getIt.registerFactory(() => LoginBloc(getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(getIt()));

  // External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
}
