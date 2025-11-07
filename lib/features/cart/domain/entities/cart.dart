import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String userUid;
  final String id;
  final String name;
  final String image;

  final String size;
  final double sizenum;
  final String color;
  final double price;
  final int qty;

  const CartEntity({
    required this.userUid,
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.sizenum,
    required this.color,
    required this.price,
    required this.qty,
  });

  CartEntity copyWith({
    int? qty,
    String? name,
    String? image,
    String? size,
    double? sizenum,
    String? color,
    double? price,
  }) {
    return CartEntity(
      userUid: userUid,
      id: id,
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      sizenum: sizenum ?? this.sizenum,
      color: color ?? this.color,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [
    userUid,
    id,
    name,
    image,
    size,
    sizenum,
    color,
    price,
    qty,
  ];
}
