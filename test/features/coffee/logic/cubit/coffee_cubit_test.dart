import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit({
    required this.fetchRandomCoffeeImageUrl,
    required this.saveFavorite,
    required this.getFavorites,
  }) : super(CoffeeInitial());

  final FetchRandomCoffeeImageUrl fetchRandomCoffeeImageUrl;
  final SaveFavorite saveFavorite;
  final GetFavorites getFavorites;

  Future<void> loadRandomCoffeeImage() async {
    emit(CoffeeLoading());
    try {
      final url = await fetchRandomCoffeeImageUrl();
      emit(CoffeeLoaded(url));
    } on SocketException {
      emit(const CoffeeError('no_internet'));
    } on Exception catch (e) {
      emit(CoffeeError(e.toString()));
    }
  }

  Future<void> saveCurrentAsFavorite({required String originalUrl}) async {
    emit(CoffeeLoading());
    try {
      final favorites = await getFavorites();
      final alreadyFavorite = favorites.any(
        (fav) => fav.originalUrl == originalUrl,
      );

      if (alreadyFavorite) {
        emit(FavoriteSavedExists());
        await loadRandomCoffeeImage();
        return;
      }

      String? localPath;
      var platform = 'web';
      if (!kIsWeb) {
        platform = Platform.operatingSystem;
        final response = await http.get(Uri.parse(originalUrl));
        final dir = await getApplicationDocumentsDirectory();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final filePath = '${dir.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        localPath = filePath;
      }

      await saveFavorite(
        originalUrl: originalUrl,
        localPath: localPath,
        platform: platform,
        createdAt: DateTime.now(),
      );
      emit(FavoriteSavedSuccess());

      await loadRandomCoffeeImage();
    } on Exception catch (e) {
      emit(CoffeeError('Error al guardar favorito: $e'));
    }
  }
}
