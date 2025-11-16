import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/checkout/domain/entities/address_entity.dart';

import 'package:ecommerce/features/checkout/domain/entities/delivery_option_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/checkout_cart_entity.dart';

sealed class CheckoutEvent extends Equatable{
  const CheckoutEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class LoadCheckoutData extends CheckoutEvent{
  final String uid;
  const LoadCheckoutData(this.uid);

  @override
  // TODO: implement props
  List<Object?> get props => [uid];

}

class SelectedAddress extends CheckoutEvent{
  final Address address;
  const SelectedAddress(this.address);

  @override
  // TODO: implement props
  List<Object?> get props => [address];

}


class SelectedDeliveryOption extends CheckoutEvent{
  final DeliveryOption deliveryOption;
  const SelectedDeliveryOption(this.deliveryOption);

  @override
  // TODO: implement props
  List<Object?> get props => [deliveryOption];

}

class SubmitCheckout extends CheckoutEvent {
  final List<CheckoutCartItem> items;
  const SubmitCheckout(this.items);

  @override
  List<Object?> get props => [items];

}


class StartCheckout extends CheckoutEvent{
  final List<CartEntity> selectedItems;
  final String userUid;

  const StartCheckout({required this.selectedItems,required this.userUid});

  @override
  List<Object?> get props => [selectedItems,userUid];

}