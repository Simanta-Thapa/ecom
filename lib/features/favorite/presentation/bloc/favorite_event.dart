import 'package:equatable/equatable.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteList extends FavoriteEvent {
  final String uid;
  const FetchFavoriteList({required this.uid});

  @override
  List<Object> get props => [uid];
}

class ToggleFavorite extends FavoriteEvent {
  final String uid;
  final String productId;

  const ToggleFavorite({required this.uid, required this.productId});

  @override
  List<Object> get props => [uid, productId];
}
