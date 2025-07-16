import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_database.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_local_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/models/coffee_favorite_model.dart';

void main() {
  late CoffeeDatabase db;
  late CoffeeLocalDataSource dataSource;

  setUp(() {
    db = CoffeeDatabase.forTesting(NativeDatabase.memory());
    dataSource = CoffeeLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'insertFavorite inserts a favorite and getAllFavorites returns it',
    () async {
      final model = CoffeeFavoriteModel(
        id: 'test-id',
        originalUrl: 'img-url',
        localPath: '/tmp/loc',
        platform: 'android',
        createdAt: DateTime(2024),
      );
      await dataSource.insertFavorite(model);

      final all = await dataSource.getAllFavorites();

      expect(all.length, 1);
      expect(all.first.id, 'test-id');
      expect(all.first.originalUrl, 'img-url');
      expect(all.first.localPath, '/tmp/loc');
      expect(all.first.platform, 'android');
      expect(all.first.createdAt, DateTime(2024));
    },
  );

  test('deleteFavorite removes a favorite', () async {
    final model = CoffeeFavoriteModel(
      id: 'test-id',
      originalUrl: 'img-url',
      localPath: '/tmp/loc',
      platform: 'android',
      createdAt: DateTime(2024),
    );
    await dataSource.insertFavorite(model);

    await dataSource.deleteFavorite('test-id');

    final all = await dataSource.getAllFavorites();

    expect(all, isEmpty);
  });
}
