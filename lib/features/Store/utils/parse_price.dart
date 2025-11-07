double parsePrice(String value){
  value = value.trim();
  final doubleValue = double.tryParse(value);
  if(doubleValue != null) return doubleValue;

  final intValue = int.tryParse(value);
  if(intValue != null) return intValue.toDouble();

  return 0.0;
}