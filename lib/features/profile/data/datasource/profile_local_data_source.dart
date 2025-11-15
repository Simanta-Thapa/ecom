import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileLocalDataSource{
  Future<String?> selectProfileImage(ImageSource source);

}


class ProfileLocalDataSourceImpl implements ProfileLocalDataSource{


  @override
  Future<String?> selectProfileImage(ImageSource source) async {
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
