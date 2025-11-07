import 'package:ecommerce/features/checkout/domain/entities/address_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/checkout_cart_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/checkout_entity.dart';
import 'package:ecommerce/features/checkout/domain/entities/delivery_option_entity.dart';
import 'package:ecommerce/features/checkout/domain/respositories/checkout_repository.dart';

import '../datasource/checkout_remote_data_source.dart';
import '../model/checkout_address_model.dart';
import '../model/checkout_model.dart';

class CheckoutRepositoryImpl implements CheckoutRepository{

  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<void> addNewAddress(String userUid, Address address) async {

    final model = AddressModel(
      name: address.name,
      street: address.street,
      city: address.city,
      postalCode: address.postalCode,
      phoneNumber: address.phoneNumber,
    );

   remoteDataSource.addNewAddress(userUid,model);
  }

  @override
  Future<List<DeliveryOption>> getDeliveryOption() async {
    final model = await remoteDataSource.getDeliverOption();
    return model;
  }

  @override
  Future<void> submitCheckOut({required Checkout checkout, required String uid}) async  {
    final model = CheckoutModel(
      items: checkout.items,
      address: checkout.address,
      deliveryOption: checkout.deliveryOption,

      total: checkout.total,
    );
    await remoteDataSource.submitCheckout(checkout:model, uid: uid);
  }

  @override
  Future<List<Address>> getUserAddresses(String userId) async  {
   final address = await remoteDataSource.getUserAddress(userId);
   return address;
  }

  @override
  Future<void> createCheckout(String userId, List<CheckoutCartItem> selectedItems) {
    // TODO: implement createCheckout
    throw UnimplementedError();
  }
  
}