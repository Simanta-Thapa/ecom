import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

enum CartStatus { initial, loading, success, failure, adding, removing }


class CartState extends Equatable {
  final CartStatus status;
  final List<CartEntity> cart;

  final String? errorMessage;
  

  const CartState({
    this.status = CartStatus.initial,
    this.cart = const [],

    this.errorMessage,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartEntity>? cart,

    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => status == CartStatus.loading;
  bool get isSuccess => status == CartStatus.success;
  bool get isFailure => status == CartStatus.failure;

  @override
  List<Object?> get props => [status, cart, errorMessage];
}
