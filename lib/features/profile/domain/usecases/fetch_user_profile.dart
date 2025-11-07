
import 'package:ecommerce/features/profile/domain/entities/profile.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';


class FetchUserProfile {
  final ProfileRepository repository;

  const FetchUserProfile({ required this.repository});


  Future<Profile> call({
    required String uid
  }) async {
      return await repository.fetchUserProfile(uid);
  }

}