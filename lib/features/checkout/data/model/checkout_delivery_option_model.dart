import '../../domain/entities/delivery_option_entity.dart';

class DeliveryOptionModel extends DeliveryOption {
  const DeliveryOptionModel({
    required super.id,
    required super.name,
    required super.cost,
    required super.estimatedTime,
  });

  factory DeliveryOptionModel.fromMap(Map<String, dynamic> map) => DeliveryOptionModel(
    id: map['id'],
    name: map['name'],
    cost: map['cost'],
    estimatedTime: Duration(days: map['estimatedDays']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'cost': cost,
    'estimatedDays': estimatedTime.inDays,
  };
}