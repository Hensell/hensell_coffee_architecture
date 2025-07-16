import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/widgets/full_image_view.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  testWidgets('shows AppBar and PhotoView with NetworkImage (EN)', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: FullImageView(
          imagePath: 'https://test.com/image.jpg',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Full Image View'), findsOneWidget);
    expect(find.byType(PhotoView), findsOneWidget);
  });

  testWidgets('shows AppBar and PhotoView with NetworkImage (ES)', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('es'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: FullImageView(
          imagePath: 'https://test.com/image.jpg',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Vista completa'), findsOneWidget);
    expect(find.byType(PhotoView), findsOneWidget);
  });
}
