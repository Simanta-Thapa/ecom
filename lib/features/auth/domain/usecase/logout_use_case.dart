import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repository/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo authRepo;
  const LogoutUseCase(this.authRepo);

  Future<Either<Failure, void>> call() async {
    return await authRepo.logOut();
  }
}
