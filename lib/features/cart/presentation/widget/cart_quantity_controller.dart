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
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: qty > 0 ? onRemove : null,
              icon: const Icon(Icons.remove),
              color: qty > 0 ? theme.colorScheme.primary : Colors.grey.shade400,
              iconSize: 20,
              splashRadius: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                qty.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              color: theme.colorScheme.primary,
              iconSize: 20,
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
