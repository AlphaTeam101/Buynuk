import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/domain/cart/entities/cart_item.dart';
import 'package:e_commerce/domain/cart/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/clear_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/get_cart_items_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce/domain/cart/usecases/update_quantity_usecase.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint

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
    debugPrint('CartStarted event received.');
    emit(state.copyWith(status: CartStatus.loading));
    await _loadCartItems(emit);
  }

  Future<void> _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    debugPrint('CartItemAdded event received for product: ${event.product.title}');
    final result = await _addToCartUseCase(event.product);
    result.fold(
      (error) {
        debugPrint('CartItemAdded failed: $error');
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        debugPrint('CartItemAdded successful. Reloading cart items.');
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    debugPrint('CartItemRemoved event received for productId: ${event.productId}');
    final result = await _removeFromCartUseCase(event.productId);
    result.fold(
      (error) {
        debugPrint('CartItemRemoved failed: $error');
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        debugPrint('CartItemRemoved successful. Reloading cart items.');
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartItemQuantityUpdated(CartItemQuantityUpdated event, Emitter<CartState> emit) async {
    debugPrint('CartItemQuantityUpdated event received for productId: ${event.productId}, quantity: ${event.quantity}');
    final result = await _updateQuantityUseCase(event.productId, event.quantity);
    result.fold(
      (error) {
        debugPrint('CartItemQuantityUpdated failed: $error');
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) async {
        debugPrint('CartItemQuantityUpdated successful. Reloading cart items.');
        await _loadCartItems(emit);
      },
    );
  }

  Future<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) async {
    debugPrint('CartCleared event received.');
    final result = await _clearCartUseCase();
    result.fold(
      (error) {
        debugPrint('CartCleared failed: $error');
        emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
      },
      (_) {
        debugPrint('CartCleared successful.');
        emit(state.copyWith(status: CartStatus.success, items: []));
      },
    );
  }

  Future<void> _loadCartItems(Emitter<CartState> emit) async {
    debugPrint('Loading cart items...');
    final result = await _getCartItemsUseCase();
    result.fold(
      (error) {
        debugPrint('Failed to load cart items: $error');
        if (!emit.isDone) {
          emit(state.copyWith(status: CartStatus.failure, errorMessage: error));
        }
      },
      (items) {
        debugPrint('Cart items loaded successfully. Total items: ${items.length}');
        if (!emit.isDone) {
          emit(state.copyWith(status: CartStatus.success, items: List.from(items)));
        }
      },
    );
  }
}
