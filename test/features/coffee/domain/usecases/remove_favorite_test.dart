import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository mockRepo;
  late RemoveFavorite usecase;

  setUp(() {
    mockRepo = MockCoffeeRepository();
    usecase = RemoveFavorite(mockRepo);
  });

  test('calls removeFavorite on repo with the correct id', () async {
    when(() => mockRepo.removeFavorite('id1')).thenAnswer((_) async {});

    await usecase('id1');

    verify(() => mockRepo.removeFavorite('id1')).called(1);
  });
}
