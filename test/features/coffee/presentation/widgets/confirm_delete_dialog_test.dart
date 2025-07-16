import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/widgets/confirm_delete_dialog.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

void main() {
  testWidgets('shows texts and returns true when delete is pressed', (
    tester,
  ) async {
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [Locale('en')],
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () async {
                result = await showConfirmDeleteDialog(
                  context,
                  AppLocalizations.of(context),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(ElevatedButton));
    final l10n = AppLocalizations.of(context);

    expect(find.text(l10n.confirmDeleteTitle), findsOneWidget);
    expect(find.text(l10n.confirmDeleteMessage), findsOneWidget);
    expect(find.text(l10n.cancel), findsOneWidget);
    expect(find.text(l10n.delete), findsOneWidget);

    await tester.tap(find.text(l10n.delete));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });
}
