part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<Product> products;
  final String query;
  final int? categoryId;
  final double? minPrice;
  final double? maxPrice;
  final bool hasReachedMax;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.products = const [],
    this.query = '',
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? products,
    String? query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    bool? hasReachedMax,
    String? errorMessage,
    bool clearFilters = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      query: query ?? this.query,
      categoryId: clearFilters ? null : categoryId ?? this.categoryId,
      minPrice: clearFilters ? null : minPrice ?? this.minPrice,
      maxPrice: clearFilters ? null : maxPrice ?? this.maxPrice,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        query,
        categoryId,
        minPrice,
        maxPrice,
        hasReachedMax,
        errorMessage,
      ];
}
