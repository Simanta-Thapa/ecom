

import '../../domain/entities/address_entity.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.name,
    required super.street,
    required super.city,
    required super.postalCode,
    required super.phoneNumber,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
    name: map['name'],
    street: map['street'],
    city: map['city'],
    postalCode: map['postalCode'],
    phoneNumber: map['phone'],
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'street': street,
    'city': city,
    'postalCode': postalCode,
    'phone': phoneNumber,
  };
}
