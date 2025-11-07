

import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {

  Future<List<FavoriteEntity>>fetchUserFavoriteList(String uid);

  Future<FavoriteEntity> toggleFavorite({required String productId,required String uid});

}
