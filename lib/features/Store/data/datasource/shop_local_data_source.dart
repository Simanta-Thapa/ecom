import 'package:image_picker/image_picker.dart';

abstract class ShopLocalDataSource{
  Future<String?> pickImage(ImageSource source);
}