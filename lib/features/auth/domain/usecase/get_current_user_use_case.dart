import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entites/user.dart';
import '../repository/auth_repo.dart';

class GetCurrentUserUseCase {
  final AuthRepo repository;
  const GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, UserUid?>> call() async {
    return await repository.getCurrentUser();
  }
}
