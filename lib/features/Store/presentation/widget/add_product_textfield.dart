import 'package:flutter/material.dart';

class AddProductTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;
  final String hintText;
    final String? Function(String?)? vaildator;
  


  const AddProductTextfield({
    required this.controller,
    this.obscureText = false,
    required this.icon,
    required this.hintText,
    this.vaildator,
  
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: 10,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],

        // Use prefix for proper alignment with multiline
        prefix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: icon,
        ),

        hintText: hintText,
        alignLabelWithHint: true, // Aligns hintText to top in multiline
        isDense: true, // optional: makes the field more compact
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),
      validator: vaildator,
    );
  }
}
