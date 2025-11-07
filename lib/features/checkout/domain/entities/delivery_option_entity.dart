class DeliveryOption {
  final String id;
  final String name;
  final double cost;
  final Duration estimatedTime;

  const DeliveryOption({
    required this.id,
    required this.name,
    required this.cost,
    required this.estimatedTime,
  });
}