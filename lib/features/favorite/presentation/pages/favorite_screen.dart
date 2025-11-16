import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Favorite"),
            Text("View More")
          ],
        ),

        Expanded(
          child: BlocBuilder<FavoriteBloc,FavoriteState>(
              builder:(context,state){
                final favoriteList = state.favorites;
                if(state.isLoading){
                  return Center(child:CircularProgressIndicator() ,);
                }

                return GridView.builder(
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: favoriteList.length,
                    itemBuilder:(context,index){
                      final data = favoriteList[index];
                      return Container(
                        child:Column(
                          children: [
                             Text(data.productId)
                          ],
                        ) ,
                      );
                    }
                );
              }
          ),
        ),
      ],
    ) ;
  }
}
