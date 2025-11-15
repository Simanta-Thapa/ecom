import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';

import 'package:ecommerce/features/auth/data/data/authremotedatasource.dart';

import 'package:ecommerce/features/auth/domain/entites/user.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repo.dart';
import 'package:ecommerce/features/auth/helpers/repository_helper.dart';

class AuthRepositoryImpl implements AuthRepo{
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, UserUid?>> getCurrentUser() {
    return remoteDataSource.execute<UserUid?>(()async{
      final user = await remoteDataSource.getCurrentUser();
      return user != null ? UserUid(user.uid) : null;
    });
  }

  @override
  Future<Either<Failure, UserUid>> googleSign() {
    // TODO: implement googleSign
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logOut() {
   return remoteDataSource.execute<void>(()=>remoteDataSource.logOut());
  }

  @override
  Future<Either<Failure, UserUid>> login(String email, String pwd) {
    return remoteDataSource.execute<UserUid>(() async {
      final user = await remoteDataSource.login(email: email, pwd: pwd);
      return UserUid(user.uid);
    });
  }

  @override
  Future<Either<Failure, UserUid>> register(String email, String pwd, String name) {
    return remoteDataSource.execute(() async{
      final user = await remoteDataSource.register(email: email, pwd: pwd, name: name);
      return UserUid(user.uid);
    });
  }
  
}