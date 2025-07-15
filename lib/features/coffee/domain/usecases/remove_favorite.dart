import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';

class RemoveFavorite {
  RemoveFavorite(this.repository);
  final CoffeeRepository repository;

  Future<void> call(String id) {
    return repository.removeFavorite(id);
  }
}
