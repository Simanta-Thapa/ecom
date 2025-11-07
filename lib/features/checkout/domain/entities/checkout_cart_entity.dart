class CheckoutCartItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;

  const CheckoutCartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });
}