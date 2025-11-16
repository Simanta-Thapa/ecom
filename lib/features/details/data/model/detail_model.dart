import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/features/details/domain/entites/details_entity.dart';
import 'package:equatable/equatable.dart';

class DetailModel extends DetailEntity with EquatableMixin{

  DetailModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.price,
    required super.uploadTime,
    required super.uid,
  });

  factory DetailModel.fromMap(Map<String,dynamic> map){
    return DetailModel(
        id:map['id'],
        name:map['name'],
        image:map['image'],
        description:map['description'],
        price:map['price'],
        uploadTime: (map['uploadTime'] as Timestamp).toDate(),
        uid:map['uid']
    );
  }


  factory DetailModel._fromEntityToDetailModel(DetailEntity entity){
    return DetailModel(
        id:entity.id,
        name: entity.name,
        image: entity.image,
        description: entity.description,
        price: entity.price,
        uploadTime: entity.uploadTime,
        uid:entity.uid
    );
  }


  DetailEntity detailModelToEntity(){
    return DetailEntity(
        id: id,
        name: name,
        image: image,
        description: description,
        price: price,
        uploadTime: uploadTime,
        uid:uid
    );
  }

}