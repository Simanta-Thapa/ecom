import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';

class FetchUserFavoriteList {
  final FavoriteRepository favoriteRepository; 
  const FetchUserFavoriteList({required this.favoriteRepository});

  Future<List<FavoriteEntity>> call({required String uid}) async {
    return await  favoriteRepository.fetchUserFavoriteList(uid);
  }
}