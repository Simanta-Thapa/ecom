import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? vaildator;
  
  const CustomTextFormField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.vaildator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller:controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        hintText:hintText,
      ),
      validator: vaildator,
    );
  }
}
