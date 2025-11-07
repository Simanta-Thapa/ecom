
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';


import '../../../../core/error/failure.dart';
import '../respositories/shop_repository.dart';


class GetProductUseCase{
  final ShopRepository repository;

  const GetProductUseCase(this.repository);


  Future<Either<Failure, List<ProductEntity>>> call() async{
    return await repository.getProducts();
  }
}