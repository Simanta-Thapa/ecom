import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';

class ToggleUserFavorite {
  final FavoriteRepository favoriteRepository;
  const ToggleUserFavorite({required this.favoriteRepository});


  Future<FavoriteEntity> call({required String productId,required String uid}) async{
   return await favoriteRepository.toggleFavorite(productId: productId,uid: uid);
  }
}