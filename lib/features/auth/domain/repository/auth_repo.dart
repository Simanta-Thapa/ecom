import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entites/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserUid>> login(String email, String pwd);
  Future<Either<Failure, UserUid>> register(String email, String pwd, String name);
  Future<Either<Failure, UserUid>> googleSign();
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, UserUid?>> getCurrentUser();
}
