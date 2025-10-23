import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/domain/products/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_by_category_event.dart';
part 'products_by_category_state.dart';

class ProductsByCategoryBloc extends Bloc<ProductsByCategoryEvent, ProductsByCategoryState> {
  final ProductRepository _productRepository;

  ProductsByCategoryBloc({required ProductRepository productRepository}) : _productRepository = productRepository, super(const ProductsByCategoryState()) {
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
  }

  Future<void> _onFetchProductsByCategory(FetchProductsByCategory event, Emitter<ProductsByCategoryState> emit) async {
    emit(state.copyWith(status: ProductsByCategoryStatus.loading));
    final result = await _productRepository.searchProducts(categoryId: event.categoryId);
    result.fold(
      (errorMessage) => emit(state.copyWith(status: ProductsByCategoryStatus.failure, errorMessage: errorMessage)),
      (products) => emit(state.copyWith(status: ProductsByCategoryStatus.success, products: products)),
    );
  }
}
