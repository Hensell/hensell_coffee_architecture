import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/main_staging.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('Carga imagen, guarda en favoritos y navega a favoritos', (
      WidgetTester tester,
    ) async {
      // Lanza la app
      app.main();
      await tester.pumpAndSettle();

      // Espera que cargue la pantalla principal
      expect(find.textContaining('Coffee'), findsOneWidget);

      // Espera que cargue la imagen
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Tap en "Guardar como favorito"
      final saveButton = find.widgetWithIcon(FilledButton, Icons.favorite);
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Espera mensaje de éxito o que recargue
      expect(
        find.textContaining('Saved to favorites').first,
        findsOneWidget,
      );

      // Navega a favoritos
      final favoritesButton = find.widgetWithIcon(OutlinedButton, Icons.list);
      expect(favoritesButton, findsOneWidget);

      await tester.tap(favoritesButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verifica que entró a favoritos (ajusta según texto que tengas en esa pantalla)
      expect(find.textContaining('Favorites'), findsOneWidget);
    });
  });
}
