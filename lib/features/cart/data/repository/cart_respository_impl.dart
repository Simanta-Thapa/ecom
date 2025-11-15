import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerce/features/cart/data/models/cart_model.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/domain/respositories/cart_repository.dart';

import '../../../../core/error/Exception.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource cartRemoteDataSource;

  const CartRepositoryImpl(this.cartRemoteDataSource);

  Future<Either<Failure, T>> _helperCartImpl<T>(
    Future<T> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(UnknowFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartItems(String userUid) {
    return _helperCartImpl(() async {
      final models = await cartRemoteDataSource.getCartItems(userUid);
      final entities = models.map((e) => e.toEntity()).toList();
      log("Entities in list in cart respoisotyr_impl ${entities.length}");
      return entities;
    });
  }

  @override
  Future<Either<Failure, void>> addItem({
    required String userUid,
    required CartEntity item,
  })  {
    return _helperCartImpl(() async{
      final model = CartModel.fromEntity(item);
      await cartRemoteDataSource.addItem(userUid: userUid, item:model);
    });
  }

  @override
  Future<Either<Failure, void>> clearCart(String uid) {
    return _helperCartImpl(()async{
      await cartRemoteDataSource.clearCart(uid);
    });
  }

  @override
  Future<Either<Failure, void>> removeItem({
    required String userUid,
    required String cartItemId,
  }) {
   return _helperCartImpl(() async{
     await cartRemoteDataSource.removeItem(userUid: userUid, cartItemId: cartItemId);
   });
  }

  @override
  Future<Either<Failure, void>> removeItems(
    String userId,
    List<CartEntity> selectedItems,
  ) {
   return  _helperCartImpl(() async{
     final models = selectedItems.map((e)=>CartModel.fromEntity(e)).toList();
      await cartRemoteDataSource.removeItems(userUid: userId, items:models);
    });
  }

  @override
  Future<Either<Failure, void>> updateQtyItem({
    required String userUid,
    required String cartItemId,
    required int qty,
  }) {
    return _helperCartImpl(() async{
      await cartRemoteDataSource.updateItemQty(userUid: userUid, cartItemId:cartItemId, qty: qty);
    });
    }
  }

