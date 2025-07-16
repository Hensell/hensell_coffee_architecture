import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository mockRepo;
  late GetFavorites usecase;

  setUp(() {
    mockRepo = MockCoffeeRepository();
    usecase = GetFavorites(mockRepo);
  });

  test('calls getFavorites on repo and returns the value', () async {
    final fakeList = [
      CoffeeFavorite(
        id: 'id1',
        originalUrl: 'url1',
        platform: 'android',
        createdAt: DateTime.now(),
      ),
    ];

    when(() => mockRepo.getFavorites()).thenAnswer((_) async => fakeList);

    final result = await usecase();

    expect(result, fakeList);
    verify(() => mockRepo.getFavorites()).called(1);
  });
}
