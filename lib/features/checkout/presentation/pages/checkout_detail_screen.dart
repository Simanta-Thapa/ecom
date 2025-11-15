import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';

class CheckoutDetailScreen extends StatefulWidget {
  final List<CartEntity> selectedItems;
  const CheckoutDetailScreen({super.key,required this.selectedItems});

  @override
  State<CheckoutDetailScreen> createState() => _CheckoutDetailScreenState();
}

class _CheckoutDetailScreenState extends State<CheckoutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
