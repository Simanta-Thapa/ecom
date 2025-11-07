import 'package:equatable/equatable.dart';

class DetailEntity extends Equatable{
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final DateTime uploadTime;

  const DetailEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.uploadTime,
});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image,description,price,uploadTime];

}