import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';


import 'package:ecommerce/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:ecommerce/features/cart/domain/usecases/remove_cart_item_use_case.dart';

import 'package:ecommerce/features/cart/domain/usecases/update_cart_item_qty_use_case.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_state.dart';
import 'package:ecommerce/features/cart/presentation/widget/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/add_to_cart_use_case.dart';
import '../../domain/usecases/get_cart_items_use_case.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final UpdateCartItemQtyUseCase updateCartItemQtyUseCase;

  CartBloc({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeCartItemUseCase,
    required this.clearCartUseCase,
    required this.updateCartItemQtyUseCase,
  }) : super(CartState()) {
    print("CartBloc initialized");
    on<FetchCart>(_onFetchCart);
    on<AddCart>(_onAddCart);

    // // on<CheckCartItem>(_onCheckCartItem);
    on<ChangeQty>(_onChangeQty);
  }


  Future<void> _helperHandleEither<T>({
    required Future<Either<Failure, T>> result,
    required Emitter<CartState> emit,
    required void Function(T data, Emitter<CartState> emit) onSuccess,
    required void Function(String message, Emitter<CartState> emit) onError,
  }) async {
    final res = await result;
    res.fold(
          (failure) => onError(_mapFailureToMessage(failure), emit),
          (data) => onSuccess(data, emit),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return "Server error. Please try again.";
    if (failure is DatabaseFailure) return "Database error occurred.";
    if (failure is UnknowFailure) return failure.msg;
    return "Unexpected error occurred.";
  }

  Future<void> _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));

    await _helperHandleEither(
      result: getCartItemsUseCase.call(event.uid),
      emit: emit,
      onSuccess: (data, emit) {
        emit(state.copyWith(status: CartStatus.success, cart: data));
      },
      onError: (msg, emit) {
        emit(state.copyWith(
            status: CartStatus.failure, cart: [], errorMessage: msg));
      },
    );
  }

  Future<void> _onAddCart(AddCart event, Emitter<CartState> emit) async {
    await _helperHandleEither(
      result: addToCartUseCase.call(userUid: event.uid, item: event.entity),
      emit: emit,
      onSuccess: (data, emit) {
        emit(state.copyWith(status: CartStatus.success));
      },
      onError: (msg, emit) {
        emit(state.copyWith(
            status: CartStatus.failure, cart: [], errorMessage: msg));
      },
    );
  }


  Future<void> _onChangeQty(ChangeQty event, Emitter<CartState> emit) async {
    await _helperHandleEither(
      result: updateCartItemQtyUseCase.call(
          userUid: event.uid, cartItemId: event.cartId, qty: event.value),
      emit: emit,
      onSuccess: (_, emit) {
        // update local state after successful backend update
        final userCartList = List<CartEntity>.from(state.cart);
        final itemIndex = userCartList.indexWhere((cart) =>
        cart.id == event.cartId);
        if (itemIndex != -1) {
          final oldItem = userCartList[itemIndex];
          final newQty = (oldItem.qty + event.value).clamp(0, 999);
          userCartList[itemIndex] =
              oldItem.copyWith(qty: oldItem.qty + event.value);
          emit(state.copyWith(cart: userCartList));
        }
      },
      onError: (msg, emit) => emit(state.copyWith(errorMessage: msg)),
    );
  }

}

