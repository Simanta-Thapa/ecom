import 'package:ecommerce/features/cart/domain/entities/cart.dart';

import '../entities/checkout_cart_entity.dart';
import '../respositories/checkout_repository.dart';

class StartCheckoutUseCase{

  final CheckoutRepository checkoutRepository;

  StartCheckoutUseCase({required this.checkoutRepository});

  Future<void> call({required String userId, required List<CartEntity> selectedItems}) async{
    await checkoutRepository.createCheckout(userId, selectedItems);
  }
}