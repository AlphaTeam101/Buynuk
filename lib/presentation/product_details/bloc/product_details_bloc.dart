import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/products/entities/product.dart';
import '../../../domain/products/usecases/get_product_by_id_usecase.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailsBloc(this._getProductByIdUseCase) : super(const ProductDetailsState()) {
    on<ProductDetailsStarted>(_onProductDetailsStarted);
  }

  Future<void> _onProductDetailsStarted(
    ProductDetailsStarted event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));

    final result = await _getProductByIdUseCase(event.productId);

    result.fold(
      (error) => emit(state.copyWith(status: ProductDetailsStatus.failure, errorMessage: error)),
      (product) => emit(state.copyWith(status: ProductDetailsStatus.success, product: product)),
    );
  }
}
