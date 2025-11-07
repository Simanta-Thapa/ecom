import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../domain/entities/cart.dart';
import 'cart_quantity_controller.dart';

class CartItem extends StatefulWidget {
  final CartEntity item;
  final String uid;
  final VoidCallback onAdd;
  final VoidCallback onRemove;


 const CartItem({
    super.key,
    required this.item,
    required this.uid,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {


  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.qty != widget.item.qty) {
      debugPrint("CartItem ${widget.item.name} actually rebuilt!");
    }
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Flexible(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      base64Decode(widget.item.image),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 50),
                    )

                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Product Details + Quantity
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
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
