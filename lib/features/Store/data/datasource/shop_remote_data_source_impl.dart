import 'dart:developer';

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
    final _newModel = ProductModel(
      uid: model.uid,
      id:docRef.id,
      name:model.name,
      description:model.description,
      price:model.price,
      image:model.image,
      uploadTime:model.uploadTime, // or Timestamp.fromDate(product.uploadTime) if needed
    );
      await docRef.set(_newModel.toMap());

  }

}