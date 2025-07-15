import 'package:equatable/equatable.dart';

class CoffeeFavorite extends Equatable {
  const CoffeeFavorite({
    required this.id,
    required this.originalUrl,
    required this.platform,
    required this.createdAt,
    this.localPath,
  });
  final String id;
  final String originalUrl;
  final String? localPath;
  final String platform;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, originalUrl, localPath, platform, createdAt];
}
