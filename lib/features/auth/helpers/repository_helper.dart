import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';


extension RepositoryHelper on Object {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
