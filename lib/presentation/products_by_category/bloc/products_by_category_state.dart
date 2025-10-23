part of 'products_by_category_bloc.dart';

enum ProductsByCategoryStatus { initial, loading, success, failure }

class ProductsByCategoryState extends Equatable {
  const ProductsByCategoryState({
    this.status = ProductsByCategoryStatus.initial,
    this.products = const [],
    this.errorMessage,
  });

  final ProductsByCategoryStatus status;
  final List<Product> products;
  final String? errorMessage;

  ProductsByCategoryState copyWith({
    ProductsByCategoryStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductsByCategoryState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
