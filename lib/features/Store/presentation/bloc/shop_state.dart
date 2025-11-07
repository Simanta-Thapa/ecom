import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';


class ShopState{
  final bool isLoading;
  final bool isAdding;
  final bool isAdded;
  final bool isFail;
  final List<ProductEntity> products;
  final String image;

  final String? errorMsg;


  const ShopState({
    this.isLoading = false,
    this.isAdding = false,
    this.isAdded = false,
    this.isFail = false,
    this.products = const [],
    this.image = '',
    this.errorMsg,
  });


  ShopState copyWith({
    bool? isLoading,
    bool? isAdding,
    bool? isAdded,
    bool? isFail,
    List<ProductEntity>? products,
    String? image,
    String? errorMsg,
}){
    return ShopState(
      isLoading: isLoading ?? this.isLoading,
      isAdding: isAdding ?? this.isAdded,
      isAdded:  isAdded ?? this.isAdded,
      isFail: isFail ?? this.isFail,
      products: products ?? this.products,
      image: image ?? this.image,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }


}