import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/user.dart';
import '../repository/auth_repo.dart';

class RegisterUseCase{
  final AuthRepo authRepo;
  const RegisterUseCase(this.authRepo);

  Future<Either<Failure, UserUid>> call({required String email,required String pwd,required String name}) async{
    return await authRepo.register(email, pwd,name);
  }

}