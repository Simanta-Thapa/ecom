 import 'package:ecommerce/features/Store/presentation/bloc/shop_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void shopBlocListener(BuildContext context,ShopState state){
  if(state.isAdding){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Uploading product...")),
    );
  } else if(state.isAdded){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully!")),
    );
  }else if (state.isFail){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${state.errorMsg}")),
    );
  }
}