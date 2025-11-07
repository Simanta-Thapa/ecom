import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/Store/data/datasource/shop_local_data_source.dart';

import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:ecommerce/features/Store/domain/respositories/shop_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../datasource/shop_remote_data_source.dart';
import '../model/product_model.dart';

class ShopRepositoryImpl implements ShopRepository{
 final ShopRemoteDataSource remoteDataSource;
 final ShopLocalDataSource localDataSource;

 const ShopRepositoryImpl ({ required this.remoteDataSource,required this.localDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async  {
    try{
      final result = await remoteDataSource.getProducts();

      final entities = result.map((e)=>e.toEntity()).toList();


      return (Right(entities));
    }catch(e){
      return Left(UnknowFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> selectedImage(ImageSource source) async {
    try{
      final result = await localDataSource.pickImage(source);
      return Right(result!);
    }catch(e){
      return Left(UnknowFailure(e.toString()));
 }
  }

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async  {
    try{
      final model = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        image: product.image,
        uploadTime: product.uploadTime, // or Timestamp.fromDate(product.uploadTime) if needed
      );
      await remoteDataSource.addProduct(model);
      return Right(null);
    }catch(e){
       return Left(UnknowFailure(e.toString()));
    }

  }

}