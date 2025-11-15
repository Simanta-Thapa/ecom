

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/profile/data/datasource/profile_local_data_source.dart';
import 'package:ecommerce/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:ecommerce/features/profile/domain/entities/profile.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';

class ProfileRespositoryImpl  implements ProfileRepository{
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRespositoryImpl({required this.profileRemoteDataSource,required this.profileLocalDataSource});

  @override
  Future<Profile> fetchUserProfile(String uid) async  {
    try{
       final profile = await profileRemoteDataSource.fetchUserProfile(uid);
    return profile;
    }catch(e){
      throw Exception(e.toString());
    }
   
  }

  @override
  Future<Either<Failure, void>> updateProfile(String uid,String name, String profilePic) async {
    try{
      final data = await profileRemoteDataSource.updateProfile(uid: uid, name: name, image:profilePic);
      return Right(data);
    }catch(e){
      return Left(UnknowFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, String>> selectImage(ImageSource source) async  {
    try{
      final image = await profileLocalDataSource.selectProfileImage(source);
      return Right(image!);
    }catch(e){
      return Left(UnknowFailure(e.toString()));
    }
  }
  
}