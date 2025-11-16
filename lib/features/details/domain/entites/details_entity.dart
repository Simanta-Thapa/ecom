import 'package:equatable/equatable.dart';

class DetailEntity extends Equatable{
  final String id;
  final String uid;
  final String name;
  final String image;
  final String description;
  final double price;
  final DateTime uploadTime;

  const DetailEntity({
    required this.id,
    required this.name,
    required this.uid,
    required this.image,
    required this.description,
    required this.price,
    required this.uploadTime,
});

  @override

  List<Object?> get props => [uid,id,name,image,description,price,uploadTime];

}