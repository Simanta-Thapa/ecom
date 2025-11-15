import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

enum CartStatus { initial, loading, success, failure, adding, removing }


class CartState extends Equatable {
  final CartStatus status;
  final List<CartEntity> cart;
  final bool hasLoaded;
  final Map<String,bool> inCart;
  final String? errorMessage;
  final Set<String> selectedCartIds;
  

  const CartState({
    this.status = CartStatus.initial,
    this.cart = const [],
    this.hasLoaded = false,
    this.inCart = const {},
    this.selectedCartIds = const {},
    this.errorMessage,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartEntity>? cart,
    bool? hasLoaded,
    Map<String,bool>? inCart,
    Set<String>? selectedCartIds,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      hasLoaded: hasLoaded ?? this.hasLoaded,
      inCart: inCart ?? this.inCart,
      selectedCartIds: selectedCartIds ?? this.selectedCartIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => status == CartStatus.loading;
  bool get isSuccess => status == CartStatus.success;
  bool get isFailure => status == CartStatus.failure;

  @override
  List<Object?> get props => [status, cart, selectedCartIds, errorMessage];
}
