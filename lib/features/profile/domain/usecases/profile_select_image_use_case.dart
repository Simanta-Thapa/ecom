import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';

class ProfileSelectImageUseCase{

  final ProfileRepository _repo;
  const ProfileSelectImageUseCase(this._repo);

  Future<Either<Failure,String>> call(ImageSource source) async{
    return await _repo.selectImage(source);
  }

}