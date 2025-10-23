import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/domain/cart/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/clear_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/get_cart_items_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/update_quantity_usecase.dart';
import 'package:e_commerce/domain/products/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateQuantityUseCase _updateQuantityUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartBloc(
    this._getCartItemsUseCase,
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._updateQuantityUseCase,
    this._clearCartUseCase,
  ) : super(const CartState()) {
    on<CartStarted>(_onCartStarted);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemQuantityUpdated>(_onCartItemQuantityUpdated);
    on<CartCleared>(_onCartCleared);
  }

  Future<void> _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    await _loadCartItems(emit);
  }

  Future<void> _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final result = await _addToCartUseCase(event.product);
    result.fold(
      (error) {
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    final result = await _removeFromCartUseCase(event.productId);
    result.fold(
      (error) {
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartItemQuantityUpdated(CartItemQuantityUpdated event, Emitter<CartState> emit) async {
    final result = await _updateQuantityUseCase(event.productId, event.quantity);
    result.fold(
      (error) {
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) async {
    final result = await _clearCartUseCase();
    result.fold(
      (error) {
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) {
        emit(state.copyWith(status: CartStatus.success, items: []));
      },
    );
  }

  Future<void> _loadCartItems(Emitter<CartState> emit) async {
    final result = await _getCartItemsUseCase();
    result.fold(
      (error) {
        if (!emit.isDone) {
          emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
        }
      },
      (items) {
        if (!emit.isDone) {
          // Ensure a new list of new CartItem instances for Equatable
          emit(state.copyWith(status: CartStatus.success, items: items.map((item) => item.copyWith()).toList()));
        }
      },
    );
  }
}
