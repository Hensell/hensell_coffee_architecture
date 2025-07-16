import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_favorites_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'coffee_database.g.dart';

@DriftDatabase(tables: [CoffeeFavoritesTable])
class CoffeeDatabase extends _$CoffeeDatabase {
  CoffeeDatabase() : super(_openConnection());

  CoffeeDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  Future<void> insertFavorite(CoffeeFavoritesTableCompanion entry) async {
    await into(coffeeFavoritesTable).insertOnConflictUpdate(entry);
  }

  Future<List<CoffeeFavoritesTableData>> getAllFavorites() async {
    return select(coffeeFavoritesTable).get();
  }

  Future<void> deleteFavorite(String id) async {
    await (delete(
      coffeeFavoritesTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'coffee_favorites.sqlite'));
    return NativeDatabase(file);
  });
}
