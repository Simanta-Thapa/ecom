import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/checkout/data/model/checkout_address_model.dart';

import 'package:ecommerce/features/checkout/data/model/checkout_delivery_option_model.dart';

import 'package:ecommerce/features/checkout/data/model/checkout_model.dart';

import 'checkout_remote_data_source.dart';

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource{
  final FirebaseFirestore firestore;

  CheckoutRemoteDataSourceImpl(this.firestore);
  
  @override
  Future<void> addNewAddress(String uid, AddressModel address) async {
   await firestore.collection("Users").doc(uid).collection("addresses").add(address.toMap());
  }

  @override
  Future<List<DeliveryOptionModel>> getDeliverOption() async {
    return [
      DeliveryOptionModel(id: 'standard', name: 'Standard', cost: 5.0, estimatedTime: Duration(days: 3)),
      DeliveryOptionModel(id: 'express', name: 'Express', cost: 10.0, estimatedTime: Duration(days: 1)),
    ];
  }

  @override
  Future<List<AddressModel>> getUserAddress(String uid) async {
   final snapshot = await firestore.collection("Users").doc(uid).collection("addresses").get();
   return snapshot.docs.map((doc) => AddressModel.fromMap(doc.data())).toList();
  }

  @override
  Future<void> submitCheckout({required CheckoutModel checkout, required String uid})async  {
    await firestore.collection("Users").doc(uid).collection("Orders").add(checkout.toMap());

  }


}