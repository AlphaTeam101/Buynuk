part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Category> categories;
  final List<Product> products;
  final bool hasReachedMaxProducts;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.products = const [],
    this.hasReachedMaxProducts = false,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? categories,
    List<Product>? products,
    bool? hasReachedMaxProducts,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      hasReachedMaxProducts: hasReachedMaxProducts ?? this.hasReachedMaxProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, products, hasReachedMaxProducts, errorMessage];
}
