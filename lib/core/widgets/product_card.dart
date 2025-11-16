import 'dart:convert';
import 'package:ecommerce/core/widgets/favorite.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/Store/domain/entities/shop_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.uid,
    required this.height,
  });

  final double height;
  final ProductEntity product;
  final String uid;



  Widget _buildImageSection(
    BuildContext context,
    String? currentUid,
    bool isOwner,
  ) {
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
        if (!isOwner)
          Positioned(
            top: 15,
            right: 10,
            child: InkWell(
              onTap: () {
                if (currentUid != null) {
                  context.read<FavoriteBloc>().add(
                    ToggleFavorite(uid: currentUid, productId: product.id),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please log in to favorite this item'),
                    ),
                  );
                }
              },
              child: Favorite(product: product),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailsSection(
    BuildContext context,
    String? currentUid,
    bool isOwner,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Text(
          "High Heels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            if (!isOwner)
              GestureDetector(
                onTap: () {
                  // Add to cart logic here
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

  @override
  Widget build(BuildContext context) {
    String? currentUid;
    final authState = context.watch<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      currentUid = authState.user.uid;
    }

    final bool isOwner = currentUid == product.uid;

    return GestureDetector(
      onTap: () => context.push('/details/${product.id}'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: _buildImageSection(context, currentUid, isOwner)),
              const SizedBox(height: 15),
              _buildDetailsSection(context, currentUid, isOwner),
            ],
          ),
        ),
      ),
    );
  }


}
