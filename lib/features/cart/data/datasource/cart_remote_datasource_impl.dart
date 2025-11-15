

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/error/Exception.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerce/features/cart/data/models/cart_model.dart';


class CartRemoteDatasourceImpl implements CartRemoteDatasource {
  final FirebaseFirestore _firestore;

  const CartRemoteDatasourceImpl(this._firestore);


  Future<void> _executeOperation(Future<void> Function() operation) async {
    try{
        await operation();
    }on FirebaseException catch (e) {
      throw DatabaseFailure(e.toString());
    } on NetworkException catch (e) {
      throw NetworkFailure(e.toString());
    } on ServerException catch (e) {
      throw ServerException('Unexpected error: $e');
    } catch (e) {
      throw UnknowFailure(e.toString());
    }

  }

  @override
  Future<List<CartModel>> getCartItems(String uid) async {

    try {
      final snapshot = await _firestore
          .collection("Users")
          .doc(uid)
          .collection("Cart")
          .get();
      log("cart remote datasource ${snapshot.docs.length}");
      return snapshot.docs
          .map((doc) => CartModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw DatabaseFailure(e.toString());
    } on NetworkException catch (e) {
      throw NetworkFailure(e.toString());
    } on ServerException catch (e) {
      throw ServerException('Unexpected error: $e');
    } catch (e) {
      throw UnknowFailure(e.toString());
    }
  }

  @override
  Future<void> addItem({required String userUid, required CartModel item,}) async {
    try {
      final docRef = _firestore
          .collection("Users")
          .doc(userUid)
          .collection("Cart")
          .doc(item.name);
      await docRef.set(item.toJson());
    } on FirebaseException catch (e) {
      throw DatabaseFailure(e.toString());
    } on NetworkException catch (e) {
      throw NetworkFailure(e.toString());
    } on ServerException catch (e) {
      throw ServerException('Unexpected error: $e');
    } catch (e) {
      throw UnknowFailure(e.toString());
    }
  }

  @override
  Future<void> clearCart(String uid) async {
    await _executeOperation(() async {
      final cartCollection = _firestore.collection("Users").doc(uid).collection("Cart");
      final snapshot = await cartCollection.get();
      for(var doc in snapshot.docs){
       await doc.reference.delete();
      }
    });
  }

  @override
  Future<void> removeItem({required String userUid, required String cartItemId,}) async {
    await _executeOperation(()async{
      final docRef = _firestore.collection("Users").doc(userUid).collection("Cart").doc(cartItemId);
      await docRef.delete();
    });
  }


  @override
  Future<void> updateItemQty({required String userUid, required cartItemId, required int qty,}) async {

    await _executeOperation(() async{
      final docRef = _firestore.collection("Users").doc(userUid).collection("Cart").doc(cartItemId);
      await docRef.update({
        'qty':qty
      });
    });
  }

  @override
  Future<void> removeItems({required String userUid, required List<CartModel> items,}) async {
   await _executeOperation(()async{
     final batch = _firestore.batch();
     final cartCollection = _firestore.collection("Users").doc(userUid).collection("Cart");
     for(var item in items){
       final docRef = cartCollection.doc(item.name);
       batch.delete(docRef);
     }

     await batch.commit();

   });

  }


}
