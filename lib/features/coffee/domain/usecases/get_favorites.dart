import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';

class GetFavorites {
  GetFavorites(this.repository);
  final CoffeeRepository repository;

  Future<List<CoffeeFavorite>> call() {
    return repository.getFavorites();
  }
}
