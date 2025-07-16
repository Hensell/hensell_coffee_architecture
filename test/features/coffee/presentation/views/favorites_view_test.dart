import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_favorites_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/favorites_view.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockCoffeeFavoritesCubit extends Mock implements CoffeeFavoritesCubit {}

void main() {
  late MockCoffeeFavoritesCubit mockCubit;

  Widget makeTestable({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<CoffeeFavoritesCubit>.value(
        value: mockCubit,
        child: child,
      ),
    );
  }

  setUp(() {
    mockCubit = MockCoffeeFavoritesCubit();

    when(() => mockCubit.loadFavorites()).thenAnswer((_) async {});
  });

  testWidgets('shows loader when loading', (tester) async {
    when(() => mockCubit.state).thenReturn(CoffeeFavoritesLoading());
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(CoffeeFavoritesLoading()));

    await tester.pumpWidget(makeTestable(child: const FavoritesView()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when error', (tester) async {
    when(() => mockCubit.state).thenReturn(const CoffeeFavoritesError('fail'));
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(const CoffeeFavoritesError('fail')));

    await tester.pumpWidget(makeTestable(child: const FavoritesView()));
    await tester.pumpAndSettle();
    expect(find.text('fail'), findsOneWidget);
  });

  testWidgets('shows empty message when no favorites', (tester) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    when(() => mockCubit.state).thenReturn(const CoffeeFavoritesLoaded([]));
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(const CoffeeFavoritesLoaded([])));

    await tester.pumpWidget(makeTestable(child: const FavoritesView()));
    await tester.pumpAndSettle();
    expect(find.text(l10n.noFavoritesYet), findsOneWidget);
  });

  testWidgets('shows favorites and can open delete dialog', (tester) async {
    await mockNetworkImages(() async {
      final now = DateTime(2024, 7, 15);
      final fav = CoffeeFavorite(
        id: 'id1',
        originalUrl: 'test-url',
        platform: 'android',
        createdAt: now,
      );
      when(() => mockCubit.state).thenReturn(CoffeeFavoritesLoaded([fav]));
      when(
        () => mockCubit.stream,
      ).thenAnswer((_) => Stream.value(CoffeeFavoritesLoaded([fav])));

      await tester.pumpWidget(makeTestable(child: const FavoritesView()));
      await tester.pumpAndSettle();

      // Checa que el favorito esté en pantalla
      expect(find.text('test-url'), findsOneWidget);

      // Intenta abrir el dialog de borrar
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      final l10n = AppLocalizations.of(
        tester.element(find.byType(FavoritesView)),
      );
      expect(find.text(l10n.confirmDeleteTitle), findsOneWidget);
      expect(find.text(l10n.delete), findsOneWidget);
    });
  });

  testWidgets('delete confirmed calls removeFavoriteById on cubit', (
    tester,
  ) async {
    final now = DateTime(2024, 7, 15);
    final fav = CoffeeFavorite(
      id: 'id1',
      originalUrl: 'test-url',
      platform: 'android',
      createdAt: now,
    );
    when(() => mockCubit.state).thenReturn(CoffeeFavoritesLoaded([fav]));
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(CoffeeFavoritesLoaded([fav])));

    // Stub del método para comprobar si se llamó
    when(() => mockCubit.removeFavoriteById('id1')).thenAnswer((_) async {});

    await tester.pumpWidget(makeTestable(child: const FavoritesView()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(FavoritesView)),
    );
    await tester.tap(find.text(l10n.delete));
    await tester.pumpAndSettle();

    verify(() => mockCubit.removeFavoriteById('id1')).called(1);
  });
}
