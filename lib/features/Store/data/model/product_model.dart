import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:equatable/equatable.dart';


class ProductModel extends ProductEntity with EquatableMixin{

  ProductModel({
    required super.image,
    required super.name,
    required super.id,
    required super.price,
    required super.description,
    required super.uploadTime
  });

  factory ProductModel.fromMap(Map<String,dynamic> map){
    return ProductModel(
        image:map['image'],
        name: map['name'],
        id: map['id'],
        price:map['price'],
        description:map['description'],
        uploadTime:(map['uploadTime'] as Timestamp).toDate(),
    );
  }


  Map<String,dynamic> toMap(){
    return {
      'image':image,
      'name':name,
      'id':id,
      'description':description,
      'price':price,
      'uploadTime':uploadTime
    };
  }

  ProductEntity toEntity(){
    return ProductEntity(
        image: image,
        name: name,
        id: id,
        price: price,
        description: description,
        uploadTime: uploadTime
    );
  }


  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      image: entity.image,
      name: entity.name,
      id: entity.id,
      price: entity.price,
      description: entity.description,
      uploadTime: entity.uploadTime,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image,name,id,description,price,uploadTime];

}