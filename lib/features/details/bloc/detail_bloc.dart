import 'package:ecommerce/features/details/bloc/detail_event.dart';
import 'package:ecommerce/features/details/bloc/detail_state.dart';
import 'package:ecommerce/features/details/domain/usecase/get_product_details_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  DetailBloc({required this.getProductDetailsUseCase}) : super(DetailState()) {
    on<FetchProductDetails>(_onFetchDetailsProduct);
  }

  Future<void> _onFetchDetailsProduct(
    FetchProductDetails event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getProductDetailsUseCase.call(event.productId);
    result.fold(
      (failure) => emit(state.copyWith(errorMsg: failure.msg,isLoading: false)),
      (result) {

        return emit(state.copyWith(detailEntity: result,isLoading: false,success: true));
      },


    );
  }
}
