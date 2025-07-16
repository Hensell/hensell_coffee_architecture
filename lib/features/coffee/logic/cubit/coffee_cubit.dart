import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'coffee_state.dart';

typedef SaveImageToDisk = Future<String?> Function(String url);

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit({
    required this.fetchRandomCoffeeImageUrl,
    required this.saveFavorite,
    required this.getFavorites,
    SaveImageToDisk? saveImageToDisk,
  }) : saveImageToDisk = saveImageToDisk ?? _defaultSaveImageToDisk,
       super(CoffeeInitial());

  final FetchRandomCoffeeImageUrl fetchRandomCoffeeImageUrl;
  final SaveFavorite saveFavorite;
  final GetFavorites getFavorites;
  final SaveImageToDisk saveImageToDisk;

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
      final platform = Platform.operatingSystem;

      if (kIsWeb) {
        localPath = null;
      } else {
        try {
          localPath = await saveImageToDisk(originalUrl);
        } on SocketException {
          final fileInfo = await DefaultCacheManager().getFileFromCache(
            originalUrl,
          );
          if (fileInfo != null && fileInfo.file.existsSync()) {
            localPath = fileInfo.file.path;
          } else {
            emit(const CoffeeError('no_internet_save_failed'));
            return;
          }
        } on Exception catch (e) {
          emit(CoffeeError(e.toString()));
          return;
        }
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
      emit(CoffeeError(e.toString()));
    }
  }

  static Future<String?> _defaultSaveImageToDisk(String url) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
