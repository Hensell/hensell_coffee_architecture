import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';

class SaveFavorite {
  SaveFavorite(this.repository);
  final CoffeeRepository repository;

  Future<CoffeeFavorite> call({
    required String originalUrl,
    required String? localPath,
    required String platform,
    DateTime? createdAt,
  }) {
    return repository.saveFavorite(
      originalUrl: originalUrl,
      localPath: localPath,
      platform: platform,
      createdAt: createdAt,
    );
  }
}
