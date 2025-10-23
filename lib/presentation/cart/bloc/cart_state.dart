part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItem> items;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.errorMessage,
  }) {
    debugPrint('CartState created/updated. Status: $status, Total items: ${items.length}');
  }

  // Calculated properties for convenience in the UI
  double get subtotal => items.fold(0, (total, item) => total + (item.product.price * item.quantity));
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
