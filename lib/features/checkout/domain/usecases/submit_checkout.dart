import 'package:ecommerce/features/checkout/domain/entities/checkout_entity.dart';
import 'package:ecommerce/features/checkout/domain/respositories/checkout_repository.dart';

class SubmitCheckoutUseCase {
  final CheckoutRepository repository;

  SubmitCheckoutUseCase(this.repository);

  Future<void> call(Checkout checkout,String uid) async {
    if (checkout.items.isEmpty) {
      throw Exception("Cannot submit checkout with no items");
    }
    return await repository.submitCheckOut(checkout: checkout, uid: uid);
  }
}