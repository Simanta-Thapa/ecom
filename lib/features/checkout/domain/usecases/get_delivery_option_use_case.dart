import 'package:ecommerce/features/checkout/domain/respositories/checkout_repository.dart';

class GetDeliveryOptionUseCase{
  final CheckoutRepository repository;
  const GetDeliveryOptionUseCase(this.repository);
}