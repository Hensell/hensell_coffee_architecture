import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';

part 'coffee_favorites_state.dart';

class CoffeeFavoritesCubit extends Cubit<CoffeeFavoritesState> {
  CoffeeFavoritesCubit({
    required this.getFavorites,
    required this.removeFavorite,
  }) : super(CoffeeFavoritesInitial());

  final GetFavorites getFavorites;
  final RemoveFavorite removeFavorite;

  Future<void> loadFavorites() async {
    emit(CoffeeFavoritesLoading());
    try {
      final favorites = await getFavorites();
      emit(CoffeeFavoritesLoaded(favorites));
    } on Exception catch (e) {
      emit(CoffeeFavoritesError(e.toString()));
    }
  }

  Future<void> removeFavoriteById(String id) async {
    try {
      await removeFavorite(id);
      await loadFavorites();
    } on Exception catch (e) {
      emit(CoffeeFavoritesError(e.toString()));
    }
  }
}
