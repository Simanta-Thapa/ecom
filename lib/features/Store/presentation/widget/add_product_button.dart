import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText_2;
  final bool isLoading;
  const AddProductButton({
    required this.onPressed,
    required this.buttonText_2,
    this.isLoading = false,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child:isLoading ? 
      SizedBox(
        height:30,
        width:200,
        child:Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15,),
            Text("Adding Product....")
            
          ],
        )
      )
      :Text(buttonText_2)
      );
  }
}