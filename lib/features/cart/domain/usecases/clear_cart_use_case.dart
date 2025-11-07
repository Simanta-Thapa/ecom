import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../respositories/cart_repository.dart';

class ClearCartUseCase{

  final CartRepository repository;
  const ClearCartUseCase(this.repository);

  Future<Either<Failure,void>> call(String userUid) {
    return  repository.clearCart(userUid);
  }
}