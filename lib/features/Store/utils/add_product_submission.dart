import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_bloc.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AddProductSubmission{
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  AddProductSubmission({required this.formKey, required this.context});

  void submit({
    required ProductEntity product
}){
    if(!formKey.currentState!.validate()) return ;
    if(product.image.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image.")),
      );
      return;
    }
    
    
    context.read<ShopBloc>().add(AddProduct(product));
  }


}