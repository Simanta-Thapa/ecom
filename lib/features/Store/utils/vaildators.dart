import 'package:ecommerce/features/Store/utils/parse_price.dart';



String? validateNotEmpty(String? value, String? fieldName){
  if(value == null || value.trim().isEmpty){
    return "Please enter $fieldName";
  }
  return null;



}


String? validatePrice(String? value){
  if(value == null || value.trim().isEmpty){
    return "Please enter price";
  }

  final price = parsePrice(value);
  if(price <= 0 ) return "Please must greater than Zero";
  
   return null;
}


