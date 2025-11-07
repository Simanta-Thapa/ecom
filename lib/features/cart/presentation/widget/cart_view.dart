import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import 'cart_item.dart';

typedef CartActionCallback = void Function(String cartId);

class CartView extends StatelessWidget {
  final String uid;
  final CartActionCallback onAdd;
  final CartActionCallback onRemove;
  const CartView({super.key,required this.uid,required this.onAdd,required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if(state.isFailure){
          return Center(child: Text("Failed to Load Cart"),);
        }
        final cart = state.cart;

        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final item = cart[index];

            return BlocBuilder<CartBloc,CartState>(
              buildWhen: (prev, curr){
                final prevItem = prev.cart.firstWhere((e)=> e.id == item.id);
                final curItem = curr.cart.firstWhere((e)=>e.id == item.id);
                return prevItem.qty != curItem.qty;
              },
              builder: (context,state) {

                final currentItem = state.cart.firstWhere((c) => c.id == item.id);

                return CartItem(
                    key: ValueKey(currentItem.id),
                    onAdd:()=>onAdd(item.id),
                    onRemove:() => onRemove(item.id),

                    item:currentItem,
                    uid: uid
                );

              }
            );
          },
        );
      },
    );
  }
}
