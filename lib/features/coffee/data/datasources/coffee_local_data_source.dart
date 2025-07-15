import 'package:drift/drift.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_database.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/models/coffee_favorite_model.dart';

class CoffeeLocalDataSource {
  CoffeeLocalDataSource(this.db);
  final CoffeeDatabase db;

  Future<void> insertFavorite(CoffeeFavoriteModel model) async {
    final entry = CoffeeFavoritesTableCompanion(
      id: Value(model.id),
      originalUrl: Value(model.originalUrl),
      localPath: Value(model.localPath),
      platform: Value(model.platform),
      createdAt: Value(model.createdAt),
    );
    await db.insertFavorite(entry);
  }

  Future<List<CoffeeFavoriteModel>> getAllFavorites() async {
    final records = await db.getAllFavorites();
    return records
        .map(
          (e) => CoffeeFavoriteModel(
            id: e.id,
            originalUrl: e.originalUrl,
            localPath: e.localPath,
            platform: e.platform,
            createdAt: e.createdAt,
          ),
        )
        .toList();
  }

  Future<void> deleteFavorite(String id) async {
    await db.deleteFavorite(id);
  }
}
