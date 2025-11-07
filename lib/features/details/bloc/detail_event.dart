import 'package:equatable/equatable.dart';

sealed class DetailEvent extends Equatable{

  const DetailEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class FetchProductDetails extends DetailEvent{
  final String productId;

  const FetchProductDetails(this.productId);

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}