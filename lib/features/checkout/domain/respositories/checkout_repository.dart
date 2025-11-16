import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/checkout/domain/entities/address_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/checkout_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/delivery_option_entity.dart';


abstract class CheckoutRepository{
  Future<void> addNewAddress(String userUid,Address address);
  Future<List<DeliveryOption>> getDeliveryOption();
  Future<void> submitCheckOut({required Checkout checkout,required String uid});
  Future<List<Address>> getUserAddresses(String userId);
  Future<void> createCheckout(String userId, List<CartEntity> selectedItems);
}