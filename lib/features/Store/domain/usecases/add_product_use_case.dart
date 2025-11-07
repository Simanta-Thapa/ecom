import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';

import '../../../../core/error/failure.dart';
import '../respositories/shop_repository.dart';

class AddProductUseCase{

  final ShopRepository repository;

  const AddProductUseCase(this.repository);

  Future<Either<Failure,void>> call(ProductEntity product) async{
    return await repository.addProduct(product);
  }
}