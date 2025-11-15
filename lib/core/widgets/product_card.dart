import 'dart:convert';

import 'package:ecommerce/core/widgets/favorite.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';

import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_event.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/Store/domain/entities/shop_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  final double height;
  const ProductCard({super.key, required this.product,required this.height});

  



  @override
  Widget build(BuildContext context) {
    // ✅ Get user from AuthBloc safely
    final authState = context.read<AuthBloc>().state;
    String? uid;

    if (authState is AuthAuthenticated) {
      uid = authState.user.uid;
    }






    return GestureDetector(
      onTap:(){
        context.push('/details/${product.id}');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: _buildImageSection(context, uid)),
              const SizedBox(height: 15),
          
          
          
              _buildDetailsSection(context,uid!,product),
            ],
          ),
        ),
      ),
    );
  
  }

  Widget _buildImageSection(BuildContext context, String? uid,) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.memory(
            base64Decode(product.image),
            width: double.infinity,

            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 15,
          right: 10,
          child: InkWell(
            onTap: () {
              if (uid != null) {
               

               context.read<FavoriteBloc>().add(ToggleFavorite(
                uid: uid, 
                productId:product.id
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please log in to favorite this item'),
                  ),
                );
              }
            },
            child:Favorite(
              product:product
              ,)
          ),
        ),
      ],
    );
  }

 Widget _buildDetailsSection(BuildContext context,String uid,ProductEntity product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        product.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      Text(
         "High Heels",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${product.price}",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0xFF26A69A),
            ),
          ),
          GestureDetector(
            onTap: () {


            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF26A69A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    ],
  );
}




}
