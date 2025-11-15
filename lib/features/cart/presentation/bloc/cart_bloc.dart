import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';

import 'package:ecommerce/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:ecommerce/features/cart/domain/usecases/remove_cart_item_use_case.dart';

import 'package:ecommerce/features/cart/domain/usecases/update_cart_item_qty_use_case.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_state.dart';

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


    on<ChangeQty>(_onChangeQty);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<ToggleSelectedItems>(_onToggleSelectedItems);
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
    if(state.hasLoaded) return ;
    emit(state.copyWith(status: CartStatus.loading));

    await _helperHandleEither(
      result: getCartItemsUseCase.call(event.uid),
      emit: emit,
      onSuccess: (data, emit) {
        final map = {for(var item in data) item.id : true};
        emit(state.copyWith(status: CartStatus.success, cart: data,hasLoaded: true,inCart: map));
       log("Cart in bloc ${data.length}");
      },
      onError: (msg, emit) {
        emit(
          state.copyWith(
            status: CartStatus.failure,
            cart: [],
            errorMessage: msg,
          ),
        );
      },
    );
  }

  Future<void> _onAddCart(AddCart event, Emitter<CartState> emit) async {
    final oldInCart = Map<String,bool>.from(state.inCart);


    final updateInCart = Map<String,bool>.from(state.inCart)..[event.entity.id] = true ;
    final updatedCart = List<CartEntity>.from(state.cart)..add(event.entity);
    emit(state.copyWith(cart: updatedCart, status: CartStatus.success, hasLoaded: true,inCart: updateInCart));

    await _helperHandleEither(
      result: addToCartUseCase.call(userUid: event.uid, item: event.entity),
      emit: emit,
      onSuccess: (data, emit) {
        emit(state.copyWith(status: CartStatus.success,inCart: updateInCart));
      },
      onError: (msg, emit) {
        emit(
          state.copyWith(
            status: CartStatus.failure,
            cart: [],
            errorMessage: msg,
          ),
        );
      },
    );
  }

  Future<void> _onChangeQty(ChangeQty event, Emitter<CartState> emit) async {
    final userCartList = List<CartEntity>.from(state.cart);

    final itemIndex = userCartList.indexWhere(
      (cart) => cart.id == event.cartId,
    );

    if (itemIndex == -1) return ;

    final oldItem = userCartList[itemIndex];
    final newQty = (oldItem.qty + event.value).clamp(0, 999);
    userCartList[itemIndex] = oldItem.copyWith(
      qty: oldItem.qty + event.value,
    );
    

    emit(state.copyWith(cart: userCartList));

    await _helperHandleEither(
      result: updateCartItemQtyUseCase.call(
        userUid: event.uid,
        cartItemId: event.cartId,
        qty:newQty,
      ),
      emit: emit,
      onSuccess: (_, emit) {
        // update local state after successful backend update
      },
      onError: (msg, emit) {

      },
    );
  }

  Future<void> _onRemoveCartItem(
    RemoveCartItem event,
    Emitter<CartState> emit,
  ) async {

    final oldInCart = Map<String,bool>.from(state.inCart);
    final oldCart = List<CartEntity>.from(state.cart);

    final removedItem = state.cart.firstWhere((c) => c.id == event.cartId);
    final updatedCart = state.cart.where((c) => c.id != event.cartId).toList();


    // cart Map



    final updateInCart = Map<String,bool>.from(state.inCart)..remove(event.cartId);


    emit(state.copyWith(cart: updatedCart, status: CartStatus.removing,inCart: updateInCart));

    await _helperHandleEither(
      result: removeCartItemUseCase.call(
        userUid: event.uid,
        cartItemId: event.cartId,

      ),
      emit: emit,
      onSuccess: (_, emit) {
        final updateCart = state.cart
            .where((c) => c.id != event.cartId)
            .toList();
        emit(state.copyWith(status: CartStatus.success));
      },
      onError: (msg, emit) {
        emit(state.copyWith(status: CartStatus.failure, errorMessage: msg,inCart: oldInCart));
      }

    );
  }


  void _onToggleSelectedItems(ToggleSelectedItems event, Emitter<CartState> emit){
    final newSelected = Set<String>.from(state.selectedCartIds);

    if(newSelected.contains(event.cartId)) {
      newSelected.remove(event.cartId);
    } else {
      newSelected.add(event.cartId);
    }


    emit(state.copyWith(selectedCartIds: newSelected));
  }



}
