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
    required super.uploadTime, required super.uid
  });

  factory ProductModel.fromMap(Map<String,dynamic> map){
    return ProductModel(
      uid: map['uid'],
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
      'uid':uid,
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
       uid: uid,
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
      uid: entity.uid,
      image: entity.image,
      name: entity.name,
      id: entity.id,
      price: entity.price,
      description: entity.description,
      uploadTime: entity.uploadTime,
    );
  }

  @override

  List<Object?> get props => [uid,image,name,id,description,price,uploadTime];

}