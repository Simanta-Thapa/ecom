import 'dart:convert';

import 'package:ecommerce/features/Store/data/datasource/shop_local_data_source.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ShopLocalDataSourceImpl implements ShopLocalDataSource{

  @override
  Future<String?> pickImage(ImageSource source ) async  {
       final picker = ImagePicker();
       final pickedFile =  await picker.pickImage(source: source,imageQuality: 70);
       if (pickedFile != null) {
         final compressed = await FlutterImageCompress.compressWithFile(
           pickedFile.path,
           quality: 70,
         );

         if (compressed != null) {
           return base64Encode(compressed);
         }
       }
       return null;
  }

}