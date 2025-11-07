import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchUserProfile(String uid);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl({required this.firestore});

  @override
  Future<ProfileModel> fetchUserProfile(String uid) async {
    try {
      // Get the document snapshot
      final docSnapshot = await firestore.collection("Users").doc(uid).get();

      if (docSnapshot.exists) {
        // Convert Firestore data to ProfileModel
        return ProfileModel.fromJson(docSnapshot.data()!);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch user profile: ${e.toString()}");
    }
  }
}
