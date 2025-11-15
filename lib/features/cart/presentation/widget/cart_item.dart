import 'dart:convert';
import 'package:flutter/material.dart';
import '../../domain/entities/cart.dart';
import 'cart_quantity_controller.dart';

class CartItem extends StatefulWidget {
  final CartEntity item;
  final String uid;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool selected;
  final VoidCallback onSelected;

  const CartItem({
    super.key,
    required this.item,
    required this.uid,
    required this.onAdd,
    required this.onRemove,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    super.initState();
    debugPrint("CartItem ${widget.item.name} initState");
  }

  @override
  void dispose() {
    debugPrint("CartItem ${widget.item.name} dispose");
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.qty != widget.item.qty) {
      debugPrint("CartItem ${widget.item.name} qty changed: ${widget.item.qty}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageBytes = base64Decode(widget.item.image);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Checkbox(
                value:widget.selected,
                onChanged: (_) => widget.onSelected(),
            ),
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            const SizedBox(width: 16),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Size: ${widget.item.size}, Color: ${widget.item.color}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${widget.item.price.toStringAsFixed(2)}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CartQuantityController(
                    qty: widget.item.qty,
                    onAdd: widget.onAdd,
                    onRemove: widget.onRemove,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
