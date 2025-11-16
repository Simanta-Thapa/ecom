import 'dart:convert';

import 'package:flutter/material.dart';

class _DetailsProductImage extends StatelessWidget {
  final GlobalKey imageKey;
  final String image;
  const _DetailsProductImage({required this.imageKey,required this.image});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      key: imageKey,
      borderRadius: BorderRadius.circular(15),
      child: Image.memory(
        base64Decode(image),
        fit: BoxFit.cover,
        width: double.infinity,
        height: screenHeight * 0.40,
      ),
    );
  }
}
