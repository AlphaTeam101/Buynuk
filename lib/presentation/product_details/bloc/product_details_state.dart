part of 'product_details_bloc.dart';

enum ProductDetailsStatus { initial, loading, success, failure }

class ProductDetailsState extends Equatable {
  final ProductDetailsStatus status;
  final Product? product;
  final String? errorMessage;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.errorMessage,
  });

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    Product? product,
    String? errorMessage,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      product: product ?? this.product,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, product, errorMessage];
}
