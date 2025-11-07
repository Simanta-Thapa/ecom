import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/auth/data/data/authremotedatasource.dart';
import 'package:ecommerce/features/auth/data/model/user_model.dart';
import 'package:ecommerce/features/auth/helpers/data_source_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final RemoteDataSourceHelper helper;

  const AuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
    required this.helper,
  });

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserModel> googleSign() {
    // TODO: implement googleSign
    throw UnimplementedError();
  }



  @override
  Future<UserModel> login({required String email, required String pwd}) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: pwd,
    );
    return helper.mapFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String pwd,
    required String name,
  }) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: pwd,
    );

    final user = helper.mapFirebaseUser(userCredential.user!);

    await helper.storeUserProfile(
      UserModel(user.uid, email: user.email, name: user.name),
    );

    return UserModel(user.uid, email: user.email, name: name);
  }


  @override
  Future<void> logOut() async {
    await auth.signOut();
  }

}







