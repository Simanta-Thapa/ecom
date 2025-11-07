import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_state.dart';
import 'package:ecommerce/features/cart/presentation/widget/cart_app_bar.dart';
import 'package:ecommerce/features/cart/presentation/widget/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/widget/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      uid = authState.user.uid;
      context.read<CartBloc>().add(FetchCart(uid!));
    }
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("Building whole cartscreen");
    if (uid == null) {
      // Handle unauthenticated case
      return const Center(child: Text("Please login to view your cart"));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CartAppBar(),
              Expanded(
                child:CartView(
                  onAdd: (cartId) {
                    print("CartBloc instance: ${context.read<CartBloc>()}");
                    context
                        .read<CartBloc>()
                        .add(ChangeQty(uid: uid!, cartId: cartId, value: 1));
                  } ,
                  onRemove: (cartId) => context
                      .read<CartBloc>()
                      .add(ChangeQty(uid: uid!, cartId: cartId, value: -1)),
                  uid: uid!,
                )
              ),

              ElevatedButton(
                  onPressed: (){

                  },
                  child:Text("Check Out")
              )
            ],
          ),
        ),
      ),
    );
  }
}
