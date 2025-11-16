import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/features/Store/data/datasource/shop_remote_data_source.dart';
import 'package:ecommerce/features/Store/data/model/product_model.dart';

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource{
  final FirebaseFirestore _firestore;

  const ShopRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<ProductModel>> getProducts() async  {
    final snapshot = await  _firestore.collection("Products").get();
    log("data source impl remote ${snapshot.size}");
    return snapshot.docs.map((e)=>ProductModel.fromMap(e.data())).toList();

  }

  @override
  Future<void> addProduct(ProductModel model) async {
    final docRef = _firestore.collection("Products").doc();
    final newModel = ProductModel(
      uid: model.uid,
      id:docRef.id,
      name:model.name,
      description:model.description,
      price:model.price,
      image:model.image,
      uploadTime:model.uploadTime, // or Timestamp.fromDate(product.uploadTime) if needed
    );
      await docRef.set(newModel.toMap());

  }
  
  @override
  Future<List<ProductModel>> fetchProductsByIds(List<String> ids) async {
    final List<ProductModel> result = [];
    for(var i = 0; i < ids.length ; i +=10){
      final favoriteIds = ids.sublist(i,math.min(i+10,ids.length));

      final snapshot = await  _firestore.collection("Products").where(FieldPath.documentId,whereIn: favoriteIds).get();
      result.addAll(snapshot.docs.map((doc)=>ProductModel.fromMap(doc.data())));
    }


    return result;

  }

}