import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_local_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_remote_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/models/coffee_favorite_model.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/repositories/coffee_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeLocalDataSource extends Mock implements CoffeeLocalDataSource {}

class MockCoffeeRemoteDataSource extends Mock
    implements CoffeeRemoteDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      CoffeeFavoriteModel(
        id: 'fake',
        originalUrl: 'fake',
        localPath: null,
        platform: 'android',
        createdAt: DateTime(2024),
      ),
    );
  });

  late CoffeeRepositoryImpl repo;
  late MockCoffeeLocalDataSource mockLocal;
  late MockCoffeeRemoteDataSource mockRemote;

  setUp(() {
    mockLocal = MockCoffeeLocalDataSource();
    mockRemote = MockCoffeeRemoteDataSource();
    repo = CoffeeRepositoryImpl(
      localDataSource: mockLocal,
      remoteDataSource: mockRemote,
    );
  });

  test('fetchRandomCoffeeImageUrl calls remoteDataSource', () async {
    when(
      () => mockRemote.fetchRandomCoffeeImageUrl(),
    ).thenAnswer((_) async => 'coffee.jpg');

    final result = await repo.fetchRandomCoffeeImageUrl();

    expect(result, 'coffee.jpg');
    verify(() => mockRemote.fetchRandomCoffeeImageUrl()).called(1);
  });

  test(
    'saveFavorite creates model, calls localDataSource, and returns favorite',
    () async {
      when(() => mockLocal.insertFavorite(any())).thenAnswer((_) async {});

      final favorite = await repo.saveFavorite(
        originalUrl: 'url1',
        localPath: '/tmp/pic.jpg',
        platform: 'android',
        createdAt: DateTime(2024),
      );

      verify(() => mockLocal.insertFavorite(any())).called(1);

      expect(favorite.originalUrl, 'url1');
      expect(favorite.localPath, '/tmp/pic.jpg');
      expect(favorite.platform, 'android');
      expect(favorite.createdAt, DateTime(2024));
      expect(favorite.id, isNotEmpty);
    },
  );

  test(
    'getFavorites calls localDataSource and maps models to entities',
    () async {
      final model = CoffeeFavoriteModel(
        id: 'id1',
        originalUrl: 'url1',
        localPath: null,
        platform: 'android',
        createdAt: DateTime(2024),
      );
      when(() => mockLocal.getAllFavorites()).thenAnswer((_) async => [model]);

      final result = await repo.getFavorites();

      expect(result.length, 1);
      expect(result[0].id, 'id1');
      expect(result[0].originalUrl, 'url1');
      expect(result[0].platform, 'android');
      expect(result[0].createdAt, DateTime(2024));
      verify(() => mockLocal.getAllFavorites()).called(1);
    },
  );

  test('removeFavorite calls localDataSource', () async {
    when(() => mockLocal.deleteFavorite('id1')).thenAnswer((_) async {});
    await repo.removeFavorite('id1');
    verify(() => mockLocal.deleteFavorite('id1')).called(1);
  });
}
