

import 'package:ecommerce/features/cart/domain/entities/cart.dart';

import 'address_entity.dart';

import 'delivery_option_entity.dart';

class Checkout {
  final List<CartEntity> items;
  final Address address;
  final DeliveryOption deliveryOption;

  final double total;

  const Checkout({
    required this.items,
    required this.address,
    required this.deliveryOption,

    required this.total,
  });

}