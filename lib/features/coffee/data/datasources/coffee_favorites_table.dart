import 'package:drift/drift.dart';

class CoffeeFavoritesTable extends Table {
  TextColumn get id => text()();
  TextColumn get originalUrl => text()();
  TextColumn get localPath => text().nullable()();
  TextColumn get platform => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
