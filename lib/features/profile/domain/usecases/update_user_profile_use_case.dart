import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';

import '../../../../core/error/failure.dart';

class UpdateProfileUseCase{
   final ProfileRepository profileRepository;

   const UpdateProfileUseCase(this.profileRepository);

   Future<Either<Failure,void>> call({required String uid,required String name,required String image}) async{
     return await profileRepository.updateProfile(uid,name, image);
   }
}