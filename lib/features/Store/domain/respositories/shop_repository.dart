import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';

abstract class ShopRepository{
  Future<Either<Failure,List<ProductEntity>>> getProducts();
  Future<Either<Failure,String>> selectedImage(ImageSource source);
  Future<Either<Failure,void>> addProduct(ProductEntity product);
  Future<Either<Failure,List<ProductEntity>>> getProductsByIds(List<String> ids);
}