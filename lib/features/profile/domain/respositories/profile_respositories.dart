
import 'package:ecommerce/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  
 Future<Profile> fetchUserProfile(String uid);
  

}