part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch all items from the local storage
class CartStarted extends CartEvent {}

/// Event to add a product to the cart
class CartItemAdded extends CartEvent {
  final Product product;

  const CartItemAdded(this.product);

  @override
  List<Object> get props => [product];
}

/// Event to remove a product from the cart
class CartItemRemoved extends CartEvent {
  final int productId;

  const CartItemRemoved(this.productId);

  @override
  List<Object> get props => [productId];
}

/// Event to update the quantity of a specific item
class CartItemQuantityUpdated extends CartEvent {
  final int productId;
  final int quantity;

  const CartItemQuantityUpdated(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

/// Event to clear the entire cart
class CartCleared extends CartEvent {}
