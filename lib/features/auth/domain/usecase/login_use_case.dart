import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';

import 'package:ecommerce/features/auth/domain/entites/user.dart';

import '../repository/auth_repo.dart';

class LoginUseCase{
  final AuthRepo authRepo;
  const LoginUseCase(this.authRepo);

  Future<Either<Failure, UserUid>> call({required String email,required String pwd}) async{
    return await authRepo.login(email, pwd);
  }

}