import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit({
    required this.fetchRandomCoffeeImageUrl,
    required this.saveFavorite,
    required this.getFavorites,
    required this.removeFavorite,
  }) : super(CoffeeInitial());
  final FetchRandomCoffeeImageUrl fetchRandomCoffeeImageUrl;
  final SaveFavorite saveFavorite;
  final GetFavorites getFavorites;
  final RemoveFavorite removeFavorite;

  Future<void> loadRandomCoffeeImage() async {
    emit(CoffeeLoading());
    try {
      final url = await fetchRandomCoffeeImageUrl();
      emit(CoffeeLoaded(url));
    } on Exception catch (e) {
      emit(CoffeeError(e.toString()));
    }
  }

  Future<void> saveCurrentAsFavorite({
    required String originalUrl,
    required String? localPath,
    required String platform,
    DateTime? createdAt,
  }) async {
    try {
      await saveFavorite(
        originalUrl: originalUrl,
        localPath: localPath,
        platform: platform,
        createdAt: createdAt,
      );

      await loadFavorites();
    } on Exception catch (e) {
      emit(CoffeeError(e.toString()));
    }
  }

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavorites();
      emit(FavoritesLoaded(favorites));
    } on Exception catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavoriteById(String id) async {
    try {
      await removeFavorite(id);
      await loadFavorites();
    } on Exception catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
