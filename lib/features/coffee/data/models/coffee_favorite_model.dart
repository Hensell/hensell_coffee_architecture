import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';

class CoffeeFavoriteModel {
  CoffeeFavoriteModel({
    required this.id,
    required this.originalUrl,
    required this.localPath,
    required this.platform,
    required this.createdAt,
  });

  factory CoffeeFavoriteModel.fromEntity(CoffeeFavorite entity) {
    return CoffeeFavoriteModel(
      id: entity.id,
      originalUrl: entity.originalUrl,
      localPath: entity.localPath,
      platform: entity.platform,
      createdAt: entity.createdAt,
    );
  }
  final String id;
  final String originalUrl;
  final String? localPath;
  final String platform;
  final DateTime createdAt;

  CoffeeFavorite toEntity() {
    return CoffeeFavorite(
      id: id,
      originalUrl: originalUrl,
      localPath: localPath,
      platform: platform,
      createdAt: createdAt,
    );
  }
}
