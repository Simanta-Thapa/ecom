import '../../../cart/presentation/widget/cart_item.dart';
import 'address_entity.dart';
import 'checkout_cart_entity.dart';
import 'delivery_option_entity.dart';

class Checkout {
  final List<CheckoutCartItem> items;
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