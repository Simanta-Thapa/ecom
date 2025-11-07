
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Store/domain/entities/shop_entity.dart';

class Favorite extends StatelessWidget {
  final ProductEntity product;
  const Favorite({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteBloc, FavoriteState, bool>(
      selector: (state) {
        return state.favorites.any((fav) => fav.productId == product.id);
      },
      builder: (context, isFavorite) {
        return CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
        );
      },
    );
  }
}
