import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/auth/data/model/user_model.dart';

class RemoteDataSourceHelper{

  final FirebaseFirestore firestore;

  const RemoteDataSourceHelper(this.firestore);


  Future<void> storeUserProfile(UserModel userModel) async{
    final docRef = firestore.collection("Users").doc(userModel.uid);
    final docSnap = await docRef.get();
    if(!docSnap.exists){
      await docRef.set(userModel.toMap());
    }
  }


  UserModel mapFirebaseUser(dynamic firebaseUser){
    return UserModel.fromFirebaseUser(firebaseUser);
  }

}