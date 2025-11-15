import 'dart:developer';


import 'package:ecommerce/features/Store/domain/usecases/add_product_use_case.dart';
import 'package:ecommerce/features/Store/domain/usecases/get_products_use_case.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_event.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/selected_image_use_case.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetProductUseCase getProductUseCase;
  final SelectedImage selectedImage;
  final AddProductUseCase addProductUseCase;
  ShopBloc({
    required this.getProductUseCase,
    required this.selectedImage,
    required this.addProductUseCase,
  }) : super(ShopState()) {
    on<FetchProducts>(_onFetchProducts);
    on<SelectImage>(_onSelectImage);
    on<AddProduct>(_onAddProduct);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ShopState> emit,
  ) async {
    final result = await getProductUseCase.call();

    result.fold(
      (failure){
        log("fetch failed: ${failure.msg}");
        emit(state.copyWith(errorMsg: failure.msg));
      },
      (result) {
        log("shop bloc received ${result.length} products");
        emit(state.copyWith(products:result));
      },
    );
  }

  Future<void> _onSelectImage(
    SelectImage event,
    Emitter<ShopState> emit,
  ) async {
    final result = await selectedImage.call(event.source);
    result.fold(
      (failure) => emit(state.copyWith(errorMsg: failure.msg)),
      (result) => emit(state.copyWith(image: result)),
    );
  }

  Future<void> _onAddProduct(AddProduct event, Emitter<ShopState> emit) async {
    emit(state.copyWith(isAdding: true));
    final result = await addProductUseCase.call(event.productEntity);
    result.fold(
      (failure) => emit(state.copyWith(errorMsg: failure.msg, isFail: true,isAdding: false)),
      (result) => emit(state.copyWith(isAdded: true, isFail: false,isAdding: false,image: null)),
    );
  }
}
