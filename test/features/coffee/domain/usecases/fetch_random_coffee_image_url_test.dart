import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';

class FetchRandomCoffeeImageUrl {
  FetchRandomCoffeeImageUrl(this.repository);
  final CoffeeRepository repository;

  Future<String> call() {
    return repository.fetchRandomCoffeeImageUrl();
  }
}
