import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/details/domain/entites/details_entity.dart';

import '../../../../core/error/failure.dart';

abstract class DetailRepository{
  Future<Either<Failure,DetailEntity>> fetchProductsDetails(String productId);
}