import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository mockRepo;
  late FetchRandomCoffeeImageUrl usecase;

  setUp(() {
    mockRepo = MockCoffeeRepository();
    usecase = FetchRandomCoffeeImageUrl(mockRepo);
  });

  test('calls fetchRandomCoffeeImageUrl on repo and returns value', () async {
    when(
      () => mockRepo.fetchRandomCoffeeImageUrl(),
    ).thenAnswer((_) async => 'coffee.jpg');

    final result = await usecase();

    expect(result, 'coffee.jpg');
    verify(() => mockRepo.fetchRandomCoffeeImageUrl()).called(1);
  });
}
