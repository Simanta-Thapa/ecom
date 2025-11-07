import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/details/data/datasource/details_remote_data_source.dart';
import 'package:ecommerce/features/details/domain/entites/details_entity.dart';
import 'package:ecommerce/features/details/domain/repository/details_repository.dart';

class DetailRepositoryImpl implements DetailRepository{
  
  final DetailRemoteDataSource _detailRemoteDataSource;
  const DetailRepositoryImpl(this._detailRemoteDataSource);

  @override
  Future<Either<Failure, DetailEntity>> fetchProductsDetails(String productId) async {
   try{
      final model  = await _detailRemoteDataSource.fetchProductDetails(productId);
      final entity  = model.detailModelToEntity();
      return Right(entity);
   }catch(e){
     return Left(ServerFailure(e.toString()));
   }
  }
  
}