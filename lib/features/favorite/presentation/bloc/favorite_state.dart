import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:equatable/equatable.dart';


class FavoriteState extends Equatable {
  final List<FavoriteEntity> favorites;
  final bool isLoading;
  final String errorMessage;

  const FavoriteState({
    this.favorites = const [], 
    this.isLoading = false,
    this.errorMessage = '',
    });

  FavoriteState copyWith({
    List<FavoriteEntity>? favorites, 
    bool? isLoading,
    String? errorMessage,
    }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object> get props => [favorites, isLoading];
}
