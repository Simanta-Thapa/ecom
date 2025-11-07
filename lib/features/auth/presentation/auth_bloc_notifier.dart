import 'dart:async';

import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class AuthBlocNotifier extends ChangeNotifier{
  final AuthBloc _authBloc;
  late final StreamSubscription _streamSubscription;


AuthBlocNotifier(this._authBloc){
  _streamSubscription = _authBloc.stream.listen((_){
   notifyListeners();
  });
}



@override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }


}