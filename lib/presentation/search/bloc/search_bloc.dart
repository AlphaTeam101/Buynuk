import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/products/entities/product.dart';
import '../../../domain/products/usecases/search_products_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

const _kSearchDebounceDuration = Duration(milliseconds: 500);
const _kSearchLimit = 10;

EventTransformer<E> _debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;

  SearchBloc(this._searchProductsUseCase) : super(const SearchState()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: _debounce(_kSearchDebounceDuration),
    );
    on<SearchFiltersApplied>(_onSearchFiltersApplied);
    on<SearchPaginated>(
      _onSearchPaginated,
      transformer: droppable(), // Prevents multiple pagination requests at once
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(state.copyWith(status: SearchStatus.initial, products: [], query: ''));
    }

    emit(state.copyWith(status: SearchStatus.loading, query: event.query, products: []));
    await _performSearch(emit, query: event.query);
  }

  Future<void> _onSearchFiltersApplied(
    SearchFiltersApplied event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(
      status: SearchStatus.loading,
      products: [],
      categoryId: event.categoryId,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    ));
    await _performSearch(emit);
  }

  Future<void> _onSearchPaginated(
    SearchPaginated event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachedMax || state.status == SearchStatus.loading) return;

    emit(state.copyWith(status: SearchStatus.loading));

    final result = await _searchProductsUseCase(
      title: state.query,
      categoryId: state.categoryId,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      offset: state.products.length,
      limit: _kSearchLimit,
    );

    result.fold(
      (error) => emit(state.copyWith(status: SearchStatus.failure, errorMessage: error)),
      (newProducts) {
        final allProducts = List<Product>.from(state.products)..addAll(newProducts);
        emit(state.copyWith(
          status: SearchStatus.success,
          products: allProducts,
          hasReachedMax: newProducts.isEmpty,
        ));
      },
    );
  }

  Future<void> _performSearch(Emitter<SearchState> emit, {String? query}) async {
    final result = await _searchProductsUseCase(
      title: query ?? state.query,
      categoryId: state.categoryId,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      offset: 0, // Always start from the beginning for a new search
      limit: _kSearchLimit,
    );

    result.fold(
      (error) => emit(state.copyWith(status: SearchStatus.failure, errorMessage: error)),
      (products) => emit(state.copyWith(
        status: SearchStatus.success,
        products: products,
        hasReachedMax: products.length < _kSearchLimit,
      )),
    );
  }
}
