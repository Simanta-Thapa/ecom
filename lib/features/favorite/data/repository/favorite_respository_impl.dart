import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:ecommerce/features/Store/domain/respositories/shop_repository.dart';
import 'package:ecommerce/features/favorite/data/datasource/favorite_remote_data_source.dart';

import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';

class FavoriteRespositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;
  final ShopRepository shopRepository;
  const FavoriteRespositoryImpl({required this.favoriteRemoteDataSource,required this.shopRepository});
  @override
  Future<List<FavoriteEntity>> fetchUserFavoriteList(String uid) async {
    try {
      return await favoriteRemoteDataSource.fetchUserFavoriteModel(uid);
    } catch (e, stack) {
      print('❌ Error in FavoriteRepositoryImpl.fetchUserFavoriteList: $e');
      print(stack);
      return [];
    }
  }

  @override
  Future<FavoriteEntity> toggleFavorite({
    required String productId,
    required String uid,
  }) async {
    try {
      return await favoriteRemoteDataSource.toggleFavorite(
        uid: uid,
        productId: productId,
      );
    } catch (e, stack) {
      print('❌ Error in FavoriteRepositoryImpl.toggleFavorite: $e');
      print(stack);
      // Return fallback entity if needed
      return FavoriteEntity(productId: productId, productBool: false);
    }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getFavoriteIds(String userId) async  {
    try{
       final favoriteIds = await favoriteRemoteDataSource.getFavoriteIds(userId);
       final products = await shopRepository.getProductsByIds(favoriteIds);
       return products;
         
    }catch(e){
          return left(UnknowFailure(e.toString()));
    }
  }
}
