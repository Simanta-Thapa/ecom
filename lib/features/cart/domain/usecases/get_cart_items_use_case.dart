import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/domain/respositories/cart_repository.dart';



class GetCartItemsUseCase{
  final CartRepository repository;
  const GetCartItemsUseCase(this.repository);

  Future<Either<Failure, List<CartEntity>>> call(String userUid) {
    return repository.getCartItems(userUid);
  }

}