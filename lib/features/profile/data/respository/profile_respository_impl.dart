

import 'package:ecommerce/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:ecommerce/features/profile/domain/entities/profile.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';

class ProfileRespositoryImpl  implements ProfileRepository{
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRespositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Profile> fetchUserProfile(String uid) async  {
    try{
       final profile = await profileRemoteDataSource.fetchUserProfile(uid);
    return profile;
    }catch(e){
      throw Exception(e.toString());
    }
   
  }
  
}