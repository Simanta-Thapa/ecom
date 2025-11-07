import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String image;
  final String name;
  final String id;
  final double price;
  final String description;
  final DateTime uploadTime; // Changed from Timestamp

  const ProductEntity({
    required this.image,
    required this.name,
    required this.id,
    required this.price,
    required this.description,
    required this.uploadTime,
  });

  @override
  List<Object?> get props => [image, name, id, price, description, uploadTime];
}
