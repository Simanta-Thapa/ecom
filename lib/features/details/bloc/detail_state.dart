import 'package:ecommerce/features/details/domain/entites/details_entity.dart';
import 'package:flutter/cupertino.dart';

class DetailState{
  final bool isLoading;
  final bool success;
  final DetailEntity? detailEntity;
  final String? errorMsg;

  const DetailState({
    this.isLoading = false,
    this.success = false,
    this.detailEntity,
    this.errorMsg,
});

  DetailState copyWith({
    bool? isLoading,
    bool? success,
    DetailEntity? detailEntity,
    String? errorMsg,
}) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      success:  success ?? this.success,
      detailEntity: detailEntity ?? this.detailEntity,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }


}