import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/details/domain/entites/details_entity.dart';
import 'package:ecommerce/features/details/domain/repository/details_repository.dart';

import '../../../../core/error/failure.dart';

class GetProductDetailsUseCase{

  final DetailRepository detailRepository;

  const GetProductDetailsUseCase(this.detailRepository);
  

  Future<Either<Failure,DetailEntity>> call(String productId) async{
    return await detailRepository.fetchProductsDetails(productId);
  }
}