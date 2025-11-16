import 'package:ecommerce/features/favorite/data/model/favorite_model.dart';

abstract class FavoriteRemoteDataSource {

  Future<List<FavoriteModel>> fetchUserFavoriteModel(String uid);

  Future<FavoriteModel> toggleFavorite({required String uid,required String productId});

  Future<List<String>> getFavoriteIds(String userId);
  
}