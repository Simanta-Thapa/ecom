import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../respositories/shop_repository.dart';

class SelectedImage{

  final ShopRepository repository;

  const SelectedImage(this.repository);


  Future<Either<Failure,String>> call(ImageSource source) async{
    return await repository.selectedImage(source);
  }

}