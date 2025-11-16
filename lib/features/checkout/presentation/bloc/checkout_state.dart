import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/checkout/domain/entities/address_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/delivery_option_entity.dart';
import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final bool isLoadingInitial;
  final bool isSubmitting;
  final bool isAddingAddress;

  final List<Address> address;
  final Address? selectedAddress;
  final List<DeliveryOption> deliveryOptions;
  final DeliveryOption? selectedDelivery;
  final List<CartEntity> items;
  final double total;

  final String? error;
  final bool isSuccess;

  const CheckoutState({
    this.isAddingAddress = false,
    this.isSubmitting = false,
    this.isLoadingInitial = false,
    this.address = const [],
    this.deliveryOptions = const [],
    this.items = const [],
    this.selectedAddress,
    this.selectedDelivery,
    this.total = 0.0,
    this.error,
    this.isSuccess = false,
  });



  CheckoutState copyWith({
    bool? isLoadingInitial,
    bool? isSubmitting,
    bool? isAddingAddress,

    List<Address>? address,
    Address? selectedAddress,
    List<DeliveryOption>? deliveryOptions,
    DeliveryOption? selectedDelivery,
     List<CartEntity>? items,
    double? total,

    String? error,
    bool? isSuccess,
}){
return CheckoutState(
  isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
  isSubmitting: isSubmitting ?? this.isSubmitting,
  isAddingAddress: isAddingAddress ?? this.isAddingAddress,
  address: address ?? this.address,
  selectedAddress: selectedAddress ?? this.selectedAddress,
  deliveryOptions: deliveryOptions ?? this.deliveryOptions,
  selectedDelivery: selectedDelivery ?? selectedDelivery,
  items: items ?? this.items,
  total: total ?? this.total,
  error: error ?? this.error,
  isSuccess: isSuccess ?? this.isSuccess,


);
}

  @override
  // TODO: implement props
  List<Object?> get props => [  isLoadingInitial,
    isSubmitting,
    isAddingAddress,

    selectedAddress,
    deliveryOptions,
    selectedDelivery,

    items,
    total,
    error,
    isSuccess,
  ];
}
