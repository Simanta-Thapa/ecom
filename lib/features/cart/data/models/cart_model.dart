import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

class CartModel extends CartEntity with EquatableMixin {
  const CartModel({
    required super.userUid,
    required super.id,
    required super.name,
    required super.image,
    required super.size,
    required super.sizenum,
    required super.color,
    required super.price,
    required super.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userUid: json['user_uid'],
      id: json['id'],
      name: json['name'],
      image: json['image'],
      size: json['size'],
      sizenum: json['size_num'],
      color: json['color'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uid': userUid,
      'id': id,
      'name': name,
      'image': image,
      'size': size,
      'size_num': sizenum, // fixed
      'color': color,
      'price': price,
      'qty': qty,
    };
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      userUid: entity.userUid,
      id: entity.id,
      name: entity.name,
      image: entity.image,
      size: entity.size,
      sizenum: entity.sizenum,
      color: entity.color,
      price: entity.price,
      qty: entity.qty,
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      userUid: userUid,
      id: id,
      name: name,
      image: image,
      size: size,
      sizenum: sizenum,
      color: color,
      price: price,
      qty: qty,
    );
  }

  @override
  List<Object?> get props => [userUid, id, name, image, size, sizenum, color, price, qty];
}
