



import '../../domain/entities/checkout_cart_entity.dart';

class CartItemModel extends CheckoutCartItem {
  const CartItemModel({
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
    productId: map['productId'],
    name: map['name'],
    price: map['price'],
    quantity: map['quantity'],
  );

  Map<String, dynamic> toMap() => {
    'productId': productId,
    'name': name,
    'price': price,
    'quantity': quantity,
  };
}