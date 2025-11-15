import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/product_card.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  void initState() {
    context.read<ShopBloc>().add(FetchProducts());
    super.initState();
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
          Expanded(
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
        ],
      ),
    );
  }
}
