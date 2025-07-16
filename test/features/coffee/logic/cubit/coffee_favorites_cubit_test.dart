import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_favorites_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFavorites extends Mock implements GetFavorites {}

class MockRemoveFavorite extends Mock implements RemoveFavorite {}

void main() {
  late CoffeeFavoritesCubit cubit;
  late MockGetFavorites mockGetFavorites;
  late MockRemoveFavorite mockRemoveFavorite;

  setUp(() {
    mockGetFavorites = MockGetFavorites();
    mockRemoveFavorite = MockRemoveFavorite();
    cubit = CoffeeFavoritesCubit(
      getFavorites: mockGetFavorites,
      removeFavorite: mockRemoveFavorite,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('CoffeeFavoritesCubit', () {
    blocTest<CoffeeFavoritesCubit, CoffeeFavoritesState>(
      'emits [CoffeeFavoritesLoading, CoffeeFavoritesLoaded] when loadFavorites succeeds',
      build: () {
        when(() => mockGetFavorites()).thenAnswer(
          (_) async => [
            CoffeeFavorite(
              id: 'id1',
              originalUrl: 'url1',
              platform: 'android',
              createdAt: DateTime.now(),
            ),
          ],
        );
        return cubit;
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        isA<CoffeeFavoritesLoading>(),
        isA<CoffeeFavoritesLoaded>().having(
          (s) => s.favorites.length,
          'length',
          1,
        ),
      ],
    );

    blocTest<CoffeeFavoritesCubit, CoffeeFavoritesState>(
      'emits [CoffeeFavoritesLoading, CoffeeFavoritesError] when getFavorites throws',
      build: () {
        when(() => mockGetFavorites()).thenThrow(Exception('fail'));
        return cubit;
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        isA<CoffeeFavoritesLoading>(),
        isA<CoffeeFavoritesError>().having(
          (s) => s.message,
          'message',
          contains('fail'),
        ),
      ],
    );

    blocTest<CoffeeFavoritesCubit, CoffeeFavoritesState>(
      'calls removeFavorite and reloads on removeFavoriteById',
      build: () {
        when(() => mockRemoveFavorite(any())).thenAnswer((_) async {});
        when(() => mockGetFavorites()).thenAnswer((_) async => []);
        return cubit;
      },
      act: (cubit) => cubit.removeFavoriteById('id1'),
      verify: (_) {
        verify(() => mockRemoveFavorite('id1')).called(1);
        verify(() => mockGetFavorites()).called(1);
      },
      expect: () => [
        isA<CoffeeFavoritesLoading>(),
        isA<CoffeeFavoritesLoaded>().having(
          (s) => s.favorites.length,
          'length',
          0,
        ),
      ],
    );

    blocTest<CoffeeFavoritesCubit, CoffeeFavoritesState>(
      'emits CoffeeFavoritesError when removeFavorite throws',
      build: () {
        when(
          () => mockRemoveFavorite(any()),
        ).thenThrow(Exception('delete fail'));
        return cubit;
      },
      act: (cubit) => cubit.removeFavoriteById('id1'),
      expect: () => [
        isA<CoffeeFavoritesError>().having(
          (s) => s.message,
          'message',
          contains('delete fail'),
        ),
      ],
    );
  });
}
