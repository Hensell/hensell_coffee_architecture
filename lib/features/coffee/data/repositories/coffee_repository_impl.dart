// features/coffee/data/repositories/coffee_repository_impl.dart

import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_local_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_remote_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/models/coffee_favorite_model.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:uuid/uuid.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  CoffeeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  final CoffeeLocalDataSource localDataSource;
  final CoffeeRemoteDataSource remoteDataSource;

  @override
  Future<String> fetchRandomCoffeeImageUrl() {
    return remoteDataSource.fetchRandomCoffeeImageUrl();
  }

  @override
  Future<CoffeeFavorite> saveFavorite({
    required String originalUrl,
    required String? localPath,
    required String platform,
    DateTime? createdAt,
  }) async {
    final favorite = CoffeeFavorite(
      id: const Uuid().v4(),
      originalUrl: originalUrl,
      localPath: localPath,
      platform: platform,
      createdAt: createdAt ?? DateTime.now(),
    );
    final model = CoffeeFavoriteModel.fromEntity(favorite);
    await localDataSource.insertFavorite(model);
    return favorite;
  }

  @override
  Future<List<CoffeeFavorite>> getFavorites() async {
    final models = await localDataSource.getAllFavorites();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> removeFavorite(String id) {
    return localDataSource.deleteFavorite(id);
  }
}
