import 'package:ecommerce/features/cart/data/models/cart_model.dart';


abstract class CartRemoteDatasource {
 Future<List<CartModel>> getCartItems(String uid);
 Future<void> addItem({required String userUid,required CartModel item});
 Future<void> removeItem({required String userUid,required String cartItemId});
 Future<void> clearCart(String uid);
 Future<void> updateItemQty({required String userUid,required String cartItemId,required int qty});
 Future<void> removeItems({required String userUid, required List<CartModel> items});

}