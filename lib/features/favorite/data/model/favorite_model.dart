import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:equatable/equatable.dart';

class FavoriteModel extends FavoriteEntity with EquatableMixin{
  FavoriteModel({
    required super.productId, required super.productBool
    });


    factory FavoriteModel.fromJson(Map<String,dynamic> json){
      
      return FavoriteModel(
        productId:json['productId'], 
        productBool:json['isFavorite']
        );

    }


     @override
  List<Object?> get props => [productId,productBool];
  
}