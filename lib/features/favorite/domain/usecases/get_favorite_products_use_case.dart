import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';

class GetFavoriteProductsUseCase {
  final  FavoriteRepository favoriteRepository;

  const GetFavoriteProductsUseCase(this.favoriteRepository);

    Future<Either<Failure, List<ProductEntity>>> call(String userId) async {
    return await favoriteRepository.getFavoriteIds(userId);
  }
  
}