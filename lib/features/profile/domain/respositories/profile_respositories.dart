
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/profile/domain/entities/profile.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';

abstract class ProfileRepository {
  
 Future<Profile> fetchUserProfile(String uid);
 Future<Either<Failure,void>> updateProfile(String uid,String name,String profilePic);
 Future<Either<Failure,String>> selectImage(ImageSource source);
  

}