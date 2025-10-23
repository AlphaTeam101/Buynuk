import 'package:dio/dio.dart';
import 'package:e_commerce/data/auth/datasources/auth_local_data_source.dart';
import 'package:e_commerce/data/auth/datasources/auth_remote_data_source.dart';
import 'package:e_commerce/data/auth/repositories/auth_repository_impl.dart';
import 'package:e_commerce/data/cart/datasources/cart_local_data_source.dart';
import 'package:e_commerce/data/cart/repositories/cart_repository_impl.dart';
import 'package:e_commerce/data/categories/datasources/category_remote_data_source.dart';
import 'package:e_commerce/data/categories/repositories/category_repository_impl.dart';
import 'package:e_commerce/data/products/datasources/product_remote_data_source.dart';
import 'package:e_commerce/data/products/repositories/product_repository_impl.dart';
import 'package:e_commerce/domain/auth/repositories/auth_repository.dart';
import 'package:e_commerce/domain/auth/usecases/login_usecase.dart';
import 'package:e_commerce/domain/cart/repositories/cart_repository.dart';
import 'package:e_commerce/domain/cart/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/clear_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/get_cart_items_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/update_quantity_usecase.dart';
import 'package:e_commerce/domain/categories/repositories/category_repository.dart';
import 'package:e_commerce/domain/categories/usecases/get_categories_usecase.dart';
import 'package:e_commerce/domain/products/repositories/product_repository.dart';
import 'package:e_commerce/domain/products/usecases/get_product_by_id_usecase.dart';
import 'package:e_commerce/domain/products/usecases/get_products_usecase.dart';
import 'package:e_commerce/domain/products/usecases/search_products_usecase.dart';
import 'package:e_commerce/presentation/auth/bloc/login_bloc.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/home/bloc/home_bloc.dart';
import 'package:e_commerce/presentation/product_details/bloc/product_details_bloc.dart';
import 'package:e_commerce/presentation/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:e_commerce/presentation/search/bloc/search_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // BLoCs
  getIt.registerFactory(() => LoginBloc(getIt()));
  getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
  getIt.registerFactory(() => SearchBloc(getIt()));
  getIt.registerFactory(() => ProductDetailsBloc(getIt()));
  getIt.registerFactory(() => ProductsByCategoryBloc(productRepository: getIt()));
  getIt.registerLazySingleton(() => CartBloc(getIt(), getIt(), getIt(), getIt(), getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCartItemsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFromCartUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateQuantityUseCase(getIt()));
  getIt.registerLazySingleton(() => ClearCartUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(getIt()));

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSourceImpl());

  // External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
}
