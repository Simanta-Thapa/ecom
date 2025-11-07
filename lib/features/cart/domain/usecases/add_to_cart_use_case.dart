import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/domain/respositories/cart_repository.dart';
import '../../../../core/error/failure.dart';

class AddToCartUseCase {
  final CartRepository repository;
  const AddToCartUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String userUid,
    required CartEntity item,
  }) {
    // Just forward the repository call — no need for try/catch here
    return repository.addItem(userUid: userUid, item: item);
  }
}
