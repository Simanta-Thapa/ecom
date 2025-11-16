import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/favorite/data/datasource/favorite_remote_data_source.dart';
import 'package:ecommerce/features/favorite/data/model/favorite_model.dart';

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource{
  final FirebaseFirestore firestore;
  const FavoriteRemoteDataSourceImpl(this.firestore);
  @override
  Future<List<FavoriteModel>> fetchUserFavoriteModel(String uid) async {
    try{
      
      final result = await firestore.collection("Users").doc(uid).collection("Favorite").get();
    
      return result.docs.map((doc)=> FavoriteModel.fromJson(doc.data())).toList();
      

    }catch(e){
       
       return [];
    }

  }
  
  @override
  Future<FavoriteModel> toggleFavorite({required String uid, required String productId}) async {
   try{
      
      final favoriteRef =
          firestore.collection("Users").doc(uid).collection("Favorite");

      final docRef = favoriteRef.doc(productId);
      final docSnapshot = await docRef.get();

      if(docSnapshot.exists){
        await docRef.delete();
        return FavoriteModel(productId: productId, productBool:false);
      }else{
        await docRef.set({
          'productId':productId,
           'isFavorite':true,
        });
        return FavoriteModel(productId: productId, productBool:true);
      }

   }catch(e){
       rethrow;
   }


  }
  
  @override
  Future<List<String>> getFavoriteIds(String userId) async {
     final snapshot = await firestore.collection("User").doc(userId).collection("Favorite").get();
    final favoriteIds = snapshot.docs.map((doc)=>doc.id).toList();
    return favoriteIds;
  }
}