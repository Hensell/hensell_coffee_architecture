import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository mockRepo;
  late SaveFavorite usecase;

  setUp(() {
    mockRepo = MockCoffeeRepository();
    usecase = SaveFavorite(mockRepo);
  });

  test(
    'calls saveFavorite on repo with correct params and returns the favorite',
    () async {
      final fakeFavorite = CoffeeFavorite(
        id: 'id1',
        originalUrl: 'url1',
        localPath: '/tmp/pic.jpg',
        platform: 'android',
        createdAt: DateTime(2024),
      );

      when(
        () => mockRepo.saveFavorite(
          originalUrl: 'url1',
          localPath: '/tmp/pic.jpg',
          platform: 'android',
          createdAt: DateTime(2024),
        ),
      ).thenAnswer((_) async => fakeFavorite);

      final result = await usecase(
        originalUrl: 'url1',
        localPath: '/tmp/pic.jpg',
        platform: 'android',
        createdAt: DateTime(2024),
      );

      expect(result, fakeFavorite);
      verify(
        () => mockRepo.saveFavorite(
          originalUrl: 'url1',
          localPath: '/tmp/pic.jpg',
          platform: 'android',
          createdAt: DateTime(2024),
        ),
      ).called(1);
    },
  );
}
