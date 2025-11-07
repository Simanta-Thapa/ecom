import 'package:ecommerce/features/favorite/data/datasource/favorite_remote_data_source.dart';

import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';

class FavoriteRespositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;
  const FavoriteRespositoryImpl({required this.favoriteRemoteDataSource});
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
}
