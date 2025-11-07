import 'package:ecommerce/features/favorite/domain/entities/favorite_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/favorite/domain/usecases/fetch_user_favorite_list.dart';
import 'package:ecommerce/features/favorite/domain/usecases/toggle_user_favorite.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FetchUserFavoriteList fetchUserFavoriteList;
  final ToggleUserFavorite toggleUserFavorite;

  FavoriteBloc({
    required this.fetchUserFavoriteList,
    required this.toggleUserFavorite,
  }) : super(const FavoriteState()) {
    on<FetchFavoriteList>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    FetchFavoriteList event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final favorites = await fetchUserFavoriteList(uid: event.uid);
      emit(state.copyWith(favorites: favorites, isLoading: false));
   
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

 /// Handles toggling a favorite item
  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    // make a copy of current favorites
    final updatedFavorites = List<FavoriteEntity>.from(state.favorites);
    final index = updatedFavorites.indexWhere(
      (f) => f.productId == event.productId,
    );

    // determine new state (toggle)
    bool isFavorite;
    if (index >= 0) {
      // product already in favorites -> remove it
      updatedFavorites.removeAt(index);
      isFavorite = false;
    } else {
      // not in favorites -> add it
      updatedFavorites.add(FavoriteEntity(
        productId: event.productId,
        productBool: true,
      ));
      isFavorite = true;
    }

    // optimistic UI update
    emit(state.copyWith(favorites: updatedFavorites));

    try {
      // update Firestore via use case
      await toggleUserFavorite(
        uid: event.uid,
        productId: event.productId,
      );
    } catch (e) {
      // rollback on failure
      if (isFavorite) {
        // we added it, but it failed -> remove
        updatedFavorites.removeWhere((f) => f.productId == event.productId);
      } else {
        // we removed it, but it failed -> add back
        updatedFavorites.add(FavoriteEntity(
          productId: event.productId,
          productBool: true,
        ));
      }

      emit(state.copyWith(
        favorites: updatedFavorites,
        errorMessage: e.toString(),
      ));
    }
  }
}
