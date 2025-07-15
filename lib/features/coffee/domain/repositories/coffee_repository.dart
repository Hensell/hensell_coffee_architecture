import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';

abstract class CoffeeRepository {
  Future<String> fetchRandomCoffeeImageUrl();

  Future<CoffeeFavorite> saveFavorite({
    required String originalUrl,
    required String? localPath,
    required String platform,
    DateTime? createdAt,
  });

  Future<List<CoffeeFavorite>> getFavorites();

  Future<void> removeFavorite(String id);
}
