import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../respositories/cart_repository.dart';

class RemoveCartItemUseCase{

  final CartRepository repository;
  const RemoveCartItemUseCase(this.repository);


  Future<Either<Failure,void>> call({required String userUid,required String cartItemId}){
    return repository.removeItem(userUid: userUid, cartItemId: cartItemId);
  }
}