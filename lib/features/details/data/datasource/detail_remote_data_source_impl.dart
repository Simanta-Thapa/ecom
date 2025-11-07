import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/details/data/datasource/details_remote_data_source.dart';
import 'package:ecommerce/features/details/data/model/detail_model.dart';

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource{
  final FirebaseFirestore _firestore;

  const DetailRemoteDataSourceImpl(this._firestore);

  @override
  Future<DetailModel> fetchProductDetails(String productId) async {
     final snapshot = await _firestore.collection("Products").doc(productId).get();
     if(!snapshot.exists || snapshot.data() == null){
       throw Exception("Product Not Found");
     }
     return DetailModel.fromMap(snapshot.data()!);
  }

}