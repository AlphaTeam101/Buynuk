part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchFiltersApplied extends SearchEvent {
  final int? categoryId;
  final double? minPrice;
  final double? maxPrice;

  const SearchFiltersApplied({this.categoryId, this.minPrice, this.maxPrice});

  @override
  List<Object?> get props => [categoryId, minPrice, maxPrice];
}

class SearchPaginated extends SearchEvent {}
