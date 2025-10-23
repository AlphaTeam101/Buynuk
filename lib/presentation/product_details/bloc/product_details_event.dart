part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailsStarted extends ProductDetailsEvent {
  final int productId;

  const ProductDetailsStarted(this.productId);

  @override
  List<Object> get props => [productId];
}
