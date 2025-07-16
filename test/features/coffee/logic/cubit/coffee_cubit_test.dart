import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchRandomCoffeeImageUrl extends Mock
    implements FetchRandomCoffeeImageUrl {}

class MockSaveFavorite extends Mock implements SaveFavorite {}

class MockGetFavorites extends Mock implements GetFavorites {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CoffeeCubit cubit;
  late MockFetchRandomCoffeeImageUrl mockFetchRandomCoffeeImageUrl;
  late MockSaveFavorite mockSaveFavorite;
  late MockGetFavorites mockGetFavorites;

  setUp(() {
    mockFetchRandomCoffeeImageUrl = MockFetchRandomCoffeeImageUrl();
    mockSaveFavorite = MockSaveFavorite();
    mockGetFavorites = MockGetFavorites();
    cubit = CoffeeCubit(
      fetchRandomCoffeeImageUrl: mockFetchRandomCoffeeImageUrl,
      saveFavorite: mockSaveFavorite,
      getFavorites: mockGetFavorites,
      saveImageToDisk: (_) async => '/tmp/fake.jpg',
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('CoffeeCubit', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, CoffeeLoaded] when loadRandomCoffeeImage succeeds',
      build: () {
        when(() => mockFetchRandomCoffeeImageUrl()).thenAnswer(
          (_) async => 'https://coffee.alexflipnote.dev/random.json',
        );
        return cubit;
      },
      act: (cubit) => cubit.loadRandomCoffeeImage(),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<CoffeeLoaded>().having(
          (s) => s.imageUrl,
          'imageUrl',
          'https://coffee.alexflipnote.dev/random.json',
        ),
      ],
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when a SocketException (no internet) occurs',
      build: () {
        when(
          () => mockFetchRandomCoffeeImageUrl(),
        ).thenThrow(const SocketException('fail'));
        return cubit;
      },
      act: (cubit) => cubit.loadRandomCoffeeImage(),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<CoffeeError>().having((s) => s.message, 'message', 'no_internet'),
      ],
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when any other exception occurs',
      build: () {
        when(
          () => mockFetchRandomCoffeeImageUrl(),
        ).thenThrow(Exception('something went wrong'));
        return cubit;
      },
      act: (cubit) => cubit.loadRandomCoffeeImage(),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<CoffeeError>().having(
          (s) => s.message,
          'message',
          contains('something went wrong'),
        ),
      ],
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, FavoriteSavedSuccess, CoffeeLoading, CoffeeLoaded] when saveCurrentAsFavorite succeeds (new favorite)',
      build: () {
        when(() => mockGetFavorites()).thenAnswer((_) async => []);
        when(
          () => mockSaveFavorite(
            originalUrl: any(named: 'originalUrl'),
            localPath: any(named: 'localPath'),
            platform: any(named: 'platform'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenAnswer(
          (_) async => CoffeeFavorite(
            id: 'id1',
            originalUrl: 'https://coffee.alexflipnote.dev/random.json',
            platform: 'web',
            createdAt: DateTime.now(),
          ),
        );
        when(() => mockFetchRandomCoffeeImageUrl()).thenAnswer(
          (_) async => 'https://coffee.alexflipnote.dev/random.json',
        );
        return cubit;
      },
      act: (cubit) => cubit.saveCurrentAsFavorite(
        originalUrl: 'https://coffee.alexflipnote.dev/random.json',
      ),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<FavoriteSavedSuccess>(),
        isA<CoffeeLoading>(),
        isA<CoffeeLoaded>().having(
          (s) => s.imageUrl,
          'imageUrl',
          'https://coffee.alexflipnote.dev/random.json',
        ),
      ],
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, FavoriteSavedExists, CoffeeLoading, CoffeeLoaded] when trying to save a duplicated favorite',
      build: () {
        when(() => mockGetFavorites()).thenAnswer(
          (_) async => [
            CoffeeFavorite(
              id: 'id1',
              originalUrl: 'https://coffee.alexflipnote.dev/random.json',
              platform: 'web',
              createdAt: DateTime.now(),
            ),
          ],
        );
        when(() => mockFetchRandomCoffeeImageUrl()).thenAnswer(
          (_) async => 'https://coffee.alexflipnote.dev/random.json',
        );
        return cubit;
      },
      act: (cubit) => cubit.saveCurrentAsFavorite(
        originalUrl: 'https://coffee.alexflipnote.dev/random.json',
      ),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<FavoriteSavedExists>(),
        isA<CoffeeLoading>(),
        isA<CoffeeLoaded>().having(
          (s) => s.imageUrl,
          'imageUrl',
          'https://coffee.alexflipnote.dev/random.json',
        ),
      ],
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when saveFavorite throws exception',
      build: () {
        when(() => mockGetFavorites()).thenAnswer((_) async => []);
        when(
          () => mockSaveFavorite(
            originalUrl: any(named: 'originalUrl'),
            localPath: any(named: 'localPath'),
            platform: any(named: 'platform'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenThrow(Exception('fail'));
        return cubit;
      },
      act: (cubit) => cubit.saveCurrentAsFavorite(
        originalUrl: 'https://coffee.alexflipnote.dev/random.json',
      ),
      expect: () => [
        isA<CoffeeLoading>(),
        isA<CoffeeError>().having(
          (s) => s.message,
          'message',
          contains('fail'),
        ),
      ],
    );
  });
}
