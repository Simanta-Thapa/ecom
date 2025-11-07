import 'package:ecommerce/features/checkout/domain/usecases/get_user_addresses_use_case.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent,CheckoutState>{
  final GetUserAddressesUserCase getUserAddressesUserCase;
  CheckoutBloc({
    required this.getUserAddressesUserCase,
}) : super(CheckoutState()){
    on<LoadCheckoutData>(_onLoadCheckoutData);
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

}