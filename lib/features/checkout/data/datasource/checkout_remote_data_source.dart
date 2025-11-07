import 'package:ecommerce/features/checkout/data/model/checkout_address_model.dart';
import 'package:ecommerce/features/checkout/data/model/checkout_delivery_option_model.dart';
import 'package:ecommerce/features/checkout/domain/entities/delivery_option_entity.dart';

import '../model/checkout_model.dart';

abstract class CheckoutRemoteDataSource{
  Future<List<AddressModel>> getUserAddress(String uid);
  Future<void> addNewAddress(String uid,AddressModel address);
  Future<List<DeliveryOptionModel>> getDeliverOption();
  Future<void> submitCheckout({required CheckoutModel checkout,required String uid});
}