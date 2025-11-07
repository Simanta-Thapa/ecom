import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(),
        Text("Cart",
        style:TextStyle(
          fontSize: 25,
        ),
        ),
        IconButton(
            onPressed: (){},
            icon:Icon(Icons.delete)
        )
      ],
    );
  }
}
