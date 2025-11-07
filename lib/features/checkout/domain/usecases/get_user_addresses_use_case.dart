import 'package:ecommerce/features/checkout/domain/entities/address_entity.dart';

import '../respositories/checkout_repository.dart';



class GetUserAddressesUserCase{
  final CheckoutRepository repository;
  const GetUserAddressesUserCase(this.repository);

  Future<List<Address>> call(String uid) async{
    return await repository.getUserAddresses(uid);
  }

}