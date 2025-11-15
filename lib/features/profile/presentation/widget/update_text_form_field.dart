import 'package:flutter/material.dart';

class UpdateTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const UpdateTextFormField({super.key,required  this.controller,required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText:hintText
      ),
    );
  }
}
