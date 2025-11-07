import 'dart:convert';


import 'package:ecommerce/core/const/const.dart';
import 'package:ecommerce/core/widgets/app_bar_1.dart';
import 'package:ecommerce/core/widgets/custom_button_2.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/features/Store/domain/entities/shop_entity.dart';





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/add_product_submission.dart';
import '../../utils/shop_bloc_listener.dart';
import '../../utils/vaildators.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import '../widget/add_product_button.dart';
import '../widget/add_product_textfield.dart';

class AddProductScreen extends StatefulWidget {

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController productDes = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  late final AddProductSubmission submitHelper;







  void _handleAddProduct(String image) {
    final product = ProductEntity(
      id: '',
      name: productController.text.trim(),
      description: productDes.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0.0,
      image: image,
      uploadTime: DateTime.now(),
    );

    submitHelper.submit(product: product);
  }



  @override
  void dispose() {

    super.dispose();
    productController.clear();
    priceController.clear();
    productDes.clear();
  }

  @override
  void initState() {
    submitHelper = AddProductSubmission(formKey: _formKey, context: context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenHeight = screen.height;
  

    return Scaffold(
      appBar: AppBar1(title: "Add Product"),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<ShopBloc, ShopState>(
          listener: (context, state) => shopBlocListener(context,state),
          builder: (context, state) {
            final image = state.image;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _reviewImage(image,screenHeight),
                      _productFormWidget(),
                      lHeight,
                      _imagePickerButton(),
                      AddProductButton(
                        onPressed:()=> _handleAddProduct(image),
                        buttonText_2: "Add Product",

                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _productFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Product Name",
            icon: Icon(Icons.title),
            controller: productController,
            vaildator: (value) => validateNotEmpty(value, "Product Name"),
          ),
          height,
          AddProductTextfield(
            controller: productDes,
            icon: Icon(Icons.description),
            hintText: "Enter the description",
            vaildator: (value) => validateNotEmpty(value, "Description"),
          ),
          height,
          CustomTextFormField(
            hintText:"Product Category",
            icon:Icon(Icons.category),
            controller:productCategory
            ),
          height,
          CustomTextFormField(
            hintText: "Enter Your Price ",
            icon: Icon(Icons.price_change),
            controller: priceController,
            vaildator: (value) => validatePrice(value),
            // keyboardType: TextInputType.number, // ✅ Suggest numeric keyboard
          ),
        ],
      ),
    );
  }

  Widget _imagePickerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton2(
          onPressed: () {
            context.read<ShopBloc>().add(SelectImage(ImageSource.gallery));
          },
          buttonText_2: "Gallery",
        ),
        SizedBox(width: 20.0),
        CustomButton2(
          onPressed: () {
            context.read<ShopBloc>().add(SelectImage(ImageSource.camera));
          },
          buttonText_2: "Camera",
        ),
      ],
    );
  }


  Widget _reviewImage(String image,double screenHeight){

    if (image.isEmpty) {
      return Container(
        height: screenHeight * 0.20,
        alignment: Alignment.center,
        color: Colors.grey[200],
        child: Text("No Image Selected", style: TextStyle(color: Colors.grey)),
      );
    }

    return SizedBox(
      height: screenHeight * 0.20,
      width: double.infinity,
      child:Image.memory(base64Decode(image),
      fit: BoxFit.cover,
      ),
    );
  }




}
