import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../respositories/cart_repository.dart';

class UpdateCartItemQtyUseCase{

  final CartRepository repository;
  const UpdateCartItemQtyUseCase(this.repository);

  Future<Either<Failure,void>> call({required String userUid,required String cartItemId,required int qty})async{
    return repository.updateQtyItem(userUid: userUid, cartItemId: cartItemId, qty: qty);
  }

}