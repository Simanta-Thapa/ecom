import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:image_picker/image_picker.dart';

sealed class ShopEvent{}

final class FetchProducts extends ShopEvent{}


final class SelectImage extends ShopEvent{
  final ImageSource source;

 SelectImage(this.source);

}


final class AddProduct extends ShopEvent{
  final ProductEntity productEntity;

  AddProduct(this.productEntity);

}