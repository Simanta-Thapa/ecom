


import 'package:ecommerce/features/cart/data/models/cart_model.dart';

import '../../domain/entities/checkout_entity.dart';
import 'checkout_address_model.dart';
import 'checkout_cart_model.dart';
import 'checkout_delivery_option_model.dart';

class CheckoutModel extends Checkout {
  const CheckoutModel({
    required super.items,
    required super.address,
    required super.deliveryOption,

    required super.total,
  });

  factory CheckoutModel.fromMap(Map<String, dynamic> map) => CheckoutModel(
    items: (map['items'] as List)
        .map((e) => CartModel.fromJson(e))
        .toList(),
    address: AddressModel.fromMap(map['address']),
    deliveryOption: DeliveryOptionModel.fromMap(map['delivery']),

    total: map['total'],
  );

  Map<String, dynamic> toMap() => {
    'items': items.map((e) => (e as CartItemModel).toMap()).toList(),
    'address': (address as AddressModel).toMap(),
    'delivery': (deliveryOption as DeliveryOptionModel).toMap(),

    'total': total,
  };
}