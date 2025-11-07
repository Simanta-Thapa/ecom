import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../Store/domain/entities/shop_entity.dart';
import '../../../cart/domain/entities/cart.dart';
import '../../../cart/presentation/bloc/cart_event.dart';

class DetailsButton extends StatelessWidget {
  final String uid;
  final ProductEntity product;
  const DetailsButton({super.key,required this.uid,required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
        builder:(context,state){

            return  GestureDetector(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.isLoading ?
                    CircularProgressIndicator() :
                    Text(
                      "Add To Cart",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

    );
  }
}
