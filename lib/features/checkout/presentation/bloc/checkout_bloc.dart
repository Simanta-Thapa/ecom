import 'package:ecommerce/features/checkout/domain/usecases/get_user_addresses_use_case.dart';
import 'package:ecommerce/features/checkout/domain/usecases/start_checkout_use_case.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent,CheckoutState>{
  final GetUserAddressesUserCase getUserAddressesUserCase;
  final StartCheckoutUseCase startCheckoutUseCase;
  CheckoutBloc({
    required this.getUserAddressesUserCase,
    required this.startCheckoutUseCase,
}) : super(CheckoutState()){
    on<LoadCheckoutData>(_onLoadCheckoutData);
    on<StartCheckout>(_onStartCheckout);
  }


  Future<void> _onLoadCheckoutData(LoadCheckoutData event,Emitter<CheckoutState> emit) async{
    emit(state.copyWith(isLoadingInitial: true));
    try{

    }catch(e){
      final address = await getUserAddressesUserCase.call(event.uid);
      emit(state.copyWith(
        isLoadingInitial:false,
        address: address,
      ));
    }
  }

  Future<void> _onStartCheckout(StartCheckout event,Emitter<CheckoutState> emit) async{
    try{
      await startCheckoutUseCase.call(userId: event.userUid, selectedItems: event.selectedItems);
    }catch(e){
      emit(state.copyWith(error: e.toString()));
    }

  }


}