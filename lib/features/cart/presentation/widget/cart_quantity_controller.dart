import 'package:flutter/material.dart';

class CartQuantityController extends StatelessWidget {
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartQuantityController({
    super.key,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: qty > 0 ? onRemove : null,
          icon: const Icon(Icons.remove),
        ),
        Text(qty.toString()),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
