import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/coffee_view.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeCubit extends Mock implements CoffeeCubit {}

void main() {
  late MockCoffeeCubit mockCubit;

  Widget makeTestable({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<CoffeeCubit>.value(
        value: mockCubit,
        child: child,
      ),
    );
  }

  setUp(() {
    mockCubit = MockCoffeeCubit();
  });

  testWidgets('calls cubit.loadRandomCoffeeImage on discover coffee button', (
    tester,
  ) async {
    when(() => mockCubit.state).thenReturn(CoffeeInitial());
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(CoffeeInitial()));
    when(() => mockCubit.loadRandomCoffeeImage()).thenAnswer((_) async {});

    await tester.pumpWidget(makeTestable(child: const CoffeeView()));
    await tester.pump();

    final button = find.byIcon(Icons.coffee);
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pump();

    verify(
      () => mockCubit.loadRandomCoffeeImage(),
    ).called(greaterThanOrEqualTo(1));
  });

  testWidgets('shows no internet UI and can retry', (tester) async {
    when(() => mockCubit.state).thenReturn(const CoffeeError('no_internet'));
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(const CoffeeError('no_internet')));
    when(() => mockCubit.loadRandomCoffeeImage()).thenAnswer((_) async {});

    await tester.pumpWidget(makeTestable(child: const CoffeeView()));
    await tester.pump();

    expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    expect(find.textContaining('Try again'), findsOneWidget);

    await tester.tap(find.textContaining('Try again'));
    await tester.pump();

    verify(
      () => mockCubit.loadRandomCoffeeImage(),
    ).called(greaterThanOrEqualTo(1));
  });

  testWidgets('shows already exists snackbar on FavoriteSavedExists', (
    tester,
  ) async {
    when(() => mockCubit.state).thenReturn(FavoriteSavedExists());
    when(
      () => mockCubit.stream,
    ).thenAnswer((_) => Stream.value(FavoriteSavedExists()));
    when(() => mockCubit.loadRandomCoffeeImage()).thenAnswer((_) async {});

    await tester.pumpWidget(makeTestable(child: const CoffeeView()));
    await tester.pump();

    final snackBarFinder = find.byWidgetPredicate(
      (widget) =>
          widget is SnackBar &&
          widget.content is Text &&
          (widget.content as Text).data!.contains('already'),
    );
    expect(snackBarFinder, findsOneWidget);
  });
}
