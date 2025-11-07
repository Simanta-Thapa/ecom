
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/presentation/widget/cart_item.dart';

import '../../../../core/error/failure.dart';

abstract class CartRepository{
  
  Future<Either<Failure,List<CartEntity>>> getCartItems(String userUid);
  Future<Either<Failure,void>> addItem({required String userUid,required CartEntity item});
  Future<Either<Failure,void>> removeItem({required String userUid,required String cartItemId});
  Future<Either<Failure,void>> clearCart(String uid);
  Future<Either<Failure,void>> updateQtyItem({required String userUid,required String cartItemId, required int qty});



  /// for checkout
  Future<void> removeItems(String userId, List<CartEntity> selectedItems);

}