import 'dart:developer';

import 'package:ecommerce/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widget/cart_app_bar.dart';
import '../widget/cart_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? uid;



  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state; // Assuming auth handled elsewhere
    uid = profileState.profile!.uid; // Replace with AuthBloc value
    context.read<CartBloc>().add(FetchCart(uid!));
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return const Center(child: Text("Please login to view your cart"));
    }

    return BlocBuilder<CartBloc,CartState>(
      
      
      
      builder: (context,state){
        
        final allItems = state.cart;
        final selectedId = state.selectedCartIds;
        
        final selectedItems = allItems.where((cart) => selectedId.contains(cart.id)).toList();
        log("Selected Items is ${selectedItems.length}");

        
        return  Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CartAppBar(),
                  Expanded(
                    child: CartView(
                      uid: uid!,

                      onAdd: (cartId) => context.read<CartBloc>().add(
                        ChangeQty(uid: uid!, cartId: cartId, value: 1),
                      ),
                      onRemove: (cartId) => context.read<CartBloc>().add(
                        ChangeQty(uid: uid!, cartId: cartId, value: -1),
                      ),
                      selectedIds:state.selectedCartIds,
                      onToggleSelect:(id)=> context.read<CartBloc>().add(ToggleSelectedItems(id)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                       context.read<CheckoutBloc>().add(StartCheckout(selectedItems: selectedItems, userUid:uid!));
                    },
                    child: const Text("Check Out"),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
