import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String productId;
  final bool productBool;


  const FavoriteEntity({
    required this.productId,
    required this.productBool,
  });
  
  @override

  List<Object?> get props => [productId,productBool];


  
}