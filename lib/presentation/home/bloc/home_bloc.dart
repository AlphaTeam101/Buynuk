import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/categories/entities/category.dart';
import '../../../domain/categories/usecases/get_categories_usecase.dart';
import '../../../domain/products/entities/product.dart';
import '../../../domain/products/usecases/get_products_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

const _kProductLimit = 10;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  HomeBloc(
    this._getCategoriesUseCase,
    this._getProductsUseCase,
  ) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeScrolledToBottom>(_onHomeScrolledToBottom);
  }

  Future<void> _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final results = await Future.wait([
      _getCategoriesUseCase(),
      _getProductsUseCase(offset: 0, limit: _kProductLimit),
    ]);

    final categoriesResult = results[0] as Either<String, List<Category>>;
    final productsResult = results[1] as Either<String, List<Product>>;

    categoriesResult.fold(
      (error) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: error)),
      (categories) {
        productsResult.fold(
          (error) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: error)),
          (products) => emit(state.copyWith(
            status: HomeStatus.success,
            categories: categories,
            products: products,
            hasReachedMaxProducts: products.length < _kProductLimit,
          )),
        );
      },
    );
  }

  Future<void> _onHomeScrolledToBottom(
    HomeScrolledToBottom event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMaxProducts || state.status == HomeStatus.loading) return;

    emit(state.copyWith(status: HomeStatus.loading)); // Visually indicates loading more

    final result = await _getProductsUseCase(
      offset: state.products.length,
      limit: _kProductLimit,
    );

    result.fold(
      (error) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: error)),
      (newProducts) {
        final allProducts = List<Product>.from(state.products)..addAll(newProducts);
        emit(state.copyWith(
          status: HomeStatus.success,
          products: allProducts,
          hasReachedMaxProducts: newProducts.isEmpty,
        ));
      },
    );
  }
}
