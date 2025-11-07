import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText_2;
  final bool isLoading;
  const CustomButton2({
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
        height:20,
        width:20,
        child:CircularProgressIndicator()
      )
      :Text(buttonText_2)
      );
  }
}