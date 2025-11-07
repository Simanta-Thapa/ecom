import 'package:ecommerce/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource{
  Future<UserModel> login({required String email,required String pwd});
  Future<UserModel> register({required String email,required String pwd,required String name});
  Future<UserModel> googleSign();
  Future<void> logOut();
  Future<UserModel?> getCurrentUser();
}