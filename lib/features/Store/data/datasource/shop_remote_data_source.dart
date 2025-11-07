import 'package:ecommerce/features/Store/data/model/product_model.dart';

abstract class ShopRemoteDataSource{
  Future<List<ProductModel>> getProducts();
  Future<void> addProduct(ProductModel model);
}