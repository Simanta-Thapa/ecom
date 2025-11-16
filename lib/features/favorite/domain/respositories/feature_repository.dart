

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {

  Future<List<FavoriteEntity>>fetchUserFavoriteList(String uid);

  Future<FavoriteEntity> toggleFavorite({required String productId,required String uid});
  Future<Either<Failure, List<ProductEntity>>> getFavoriteIds(String userId);

}
