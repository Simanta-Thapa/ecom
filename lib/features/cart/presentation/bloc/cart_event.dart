
import 'package:equatable/equatable.dart';

import '../../domain/entities/cart.dart';

sealed class CartEvent extends Equatable{
  const CartEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddCart extends CartEvent {
  final String uid;
  final CartEntity entity;

  const AddCart(this.uid, this.entity);

  @override
  List<Object?> get props => [uid, entity];
}

class FetchCart extends CartEvent{

  final String uid;
  const FetchCart(this.uid);

  @override
  // TODO: implement props
  List<Object?> get props =>[uid];
}


class CheckCartItem extends CartEvent{
  final String uid;
  final String cartId;

  const CheckCartItem({required this.uid,required this.cartId});
  
  @override
  // TODO: implement props
  List<Object?> get props =>[uid,cartId];
}


class ChangeQty extends CartEvent{
  final String uid;
  final String cartId;
  final int value;

  const ChangeQty({required this.uid,required this.cartId,required this.value,});

@override
  // TODO: implement props
  List<Object?> get props => [uid,cartId,value];

}


class RemoveCartItem extends CartEvent{
  final String uid;
  final String cartId;

  const RemoveCartItem({required this.uid,required this.cartId});


}


class ToggleSelectedItems extends CartEvent{
  final String cartId;

  const ToggleSelectedItems(this.cartId);


  @override
  List<Object?> get props => [cartId];

}