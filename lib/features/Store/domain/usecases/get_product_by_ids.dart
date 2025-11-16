import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';

import 'package:ecommerce/features/Store/domain/respositories/shop_repository.dart';

class GetProductsByIds{
  final ShopRepository repo;

  const GetProductsByIds(this.repo);

  Future<Either<Failure,void>> call(List<String> ids) async{
    return await repo.getProductsByIds(ids);
  }

}