import 'dart:developer';
import 'package:ecommerce/core/widgets/product_card.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_bloc.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_event.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_state.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
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
              const Text("Welcome", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              color: Colors.yellow.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // keep cards away from border
              child: BlocBuilder<ShopBloc, ShopState>(
                builder: (context, state) {
                  final products = state.products;

                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  log("Products loaded: ${products.length}");

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final data = products[index];
                      return ProductCard(
                        height: cardHeight, // dynamically sized
                        product: data,

                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
