import 'package:dartz/dartz.dart';

import '../model/detail_model.dart';

abstract class DetailRemoteDataSource{
  Future<DetailModel> fetchProductDetails(String productId);
}