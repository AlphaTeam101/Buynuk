part of 'products_by_category_bloc.dart';

abstract class ProductsByCategoryEvent extends Equatable {
  const ProductsByCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsByCategory extends ProductsByCategoryEvent {
  final int categoryId;

  const FetchProductsByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
