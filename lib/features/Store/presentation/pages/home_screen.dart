import 'dart:developer';
import 'package:ecommerce/core/widgets/product_card.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_bloc.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_event.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_state.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    final containerHeight = screen.height * 0.50; // container = 50% of screen
    final cardHeight = containerHeight * 0.80; // card = 80% of container

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome,", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  // BlocBuilder<ProfileBloc,ProfileState>(builder:(context,state){
                  //   final profileName = state.profile!.name;
                  //   return Text(profileName);
                  // } ),
                ],
              ),

              IconButton(
                 onPressed: (){
                   context.push('/cart');
                 },
                icon: const Icon(Icons.shopping_cart),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Product grid container


        ],
      ),
    );
  }
}
