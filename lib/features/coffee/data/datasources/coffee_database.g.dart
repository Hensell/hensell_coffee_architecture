// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_database.dart';

// ignore_for_file: type=lint
class $CoffeeFavoritesTableTable extends CoffeeFavoritesTable
    with TableInfo<$CoffeeFavoritesTableTable, CoffeeFavoritesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeFavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalUrlMeta = const VerificationMeta(
    'originalUrl',
  );
  @override
  late final GeneratedColumn<String> originalUrl = GeneratedColumn<String>(
    'original_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalUrl,
    localPath,
    platform,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_favorites_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeFavoritesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('original_url')) {
      context.handle(
        _originalUrlMeta,
        originalUrl.isAcceptableOrUnknown(
          data['original_url']!,
          _originalUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalUrlMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoffeeFavoritesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeFavoritesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      originalUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_url'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CoffeeFavoritesTableTable createAlias(String alias) {
    return $CoffeeFavoritesTableTable(attachedDatabase, alias);
  }
}

class CoffeeFavoritesTableData extends DataClass
    implements Insertable<CoffeeFavoritesTableData> {
  final String id;
  final String originalUrl;
  final String? localPath;
  final String platform;
  final DateTime createdAt;
  const CoffeeFavoritesTableData({
    required this.id,
    required this.originalUrl,
    this.localPath,
    required this.platform,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['original_url'] = Variable<String>(originalUrl);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    map['platform'] = Variable<String>(platform);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CoffeeFavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return CoffeeFavoritesTableCompanion(
      id: Value(id),
      originalUrl: Value(originalUrl),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      platform: Value(platform),
      createdAt: Value(createdAt),
    );
  }

  factory CoffeeFavoritesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeFavoritesTableData(
      id: serializer.fromJson<String>(json['id']),
      originalUrl: serializer.fromJson<String>(json['originalUrl']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      platform: serializer.fromJson<String>(json['platform']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'originalUrl': serializer.toJson<String>(originalUrl),
      'localPath': serializer.toJson<String?>(localPath),
      'platform': serializer.toJson<String>(platform),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CoffeeFavoritesTableData copyWith({
    String? id,
    String? originalUrl,
    Value<String?> localPath = const Value.absent(),
    String? platform,
    DateTime? createdAt,
  }) => CoffeeFavoritesTableData(
    id: id ?? this.id,
    originalUrl: originalUrl ?? this.originalUrl,
    localPath: localPath.present ? localPath.value : this.localPath,
    platform: platform ?? this.platform,
    createdAt: createdAt ?? this.createdAt,
  );
  CoffeeFavoritesTableData copyWithCompanion(
    CoffeeFavoritesTableCompanion data,
  ) {
    return CoffeeFavoritesTableData(
      id: data.id.present ? data.id.value : this.id,
      originalUrl: data.originalUrl.present
          ? data.originalUrl.value
          : this.originalUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      platform: data.platform.present ? data.platform.value : this.platform,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeFavoritesTableData(')
          ..write('id: $id, ')
          ..write('originalUrl: $originalUrl, ')
          ..write('localPath: $localPath, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, originalUrl, localPath, platform, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeFavoritesTableData &&
          other.id == this.id &&
          other.originalUrl == this.originalUrl &&
          other.localPath == this.localPath &&
          other.platform == this.platform &&
          other.createdAt == this.createdAt);
}

class CoffeeFavoritesTableCompanion
    extends UpdateCompanion<CoffeeFavoritesTableData> {
  final Value<String> id;
  final Value<String> originalUrl;
  final Value<String?> localPath;
  final Value<String> platform;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CoffeeFavoritesTableCompanion({
    this.id = const Value.absent(),
    this.originalUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.platform = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeFavoritesTableCompanion.insert({
    required String id,
    required String originalUrl,
    this.localPath = const Value.absent(),
    required String platform,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       originalUrl = Value(originalUrl),
       platform = Value(platform),
       createdAt = Value(createdAt);
  static Insertable<CoffeeFavoritesTableData> custom({
    Expression<String>? id,
    Expression<String>? originalUrl,
    Expression<String>? localPath,
    Expression<String>? platform,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalUrl != null) 'original_url': originalUrl,
      if (localPath != null) 'local_path': localPath,
      if (platform != null) 'platform': platform,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeFavoritesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? originalUrl,
    Value<String?>? localPath,
    Value<String>? platform,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CoffeeFavoritesTableCompanion(
      id: id ?? this.id,
      originalUrl: originalUrl ?? this.originalUrl,
      localPath: localPath ?? this.localPath,
      platform: platform ?? this.platform,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (originalUrl.present) {
      map['original_url'] = Variable<String>(originalUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeFavoritesTableCompanion(')
          ..write('id: $id, ')
          ..write('originalUrl: $originalUrl, ')
          ..write('localPath: $localPath, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CoffeeDatabase extends GeneratedDatabase {
  _$CoffeeDatabase(QueryExecutor e) : super(e);
  $CoffeeDatabaseManager get managers => $CoffeeDatabaseManager(this);
  late final $CoffeeFavoritesTableTable coffeeFavoritesTable =
      $CoffeeFavoritesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [coffeeFavoritesTable];
}

typedef $$CoffeeFavoritesTableTableCreateCompanionBuilder =
    CoffeeFavoritesTableCompanion Function({
      required String id,
      required String originalUrl,
      Value<String?> localPath,
      required String platform,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CoffeeFavoritesTableTableUpdateCompanionBuilder =
    CoffeeFavoritesTableCompanion Function({
      Value<String> id,
      Value<String> originalUrl,
      Value<String?> localPath,
      Value<String> platform,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CoffeeFavoritesTableTableFilterComposer
    extends Composer<_$CoffeeDatabase, $CoffeeFavoritesTableTable> {
  $$CoffeeFavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalUrl => $composableBuilder(
    column: $table.originalUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoffeeFavoritesTableTableOrderingComposer
    extends Composer<_$CoffeeDatabase, $CoffeeFavoritesTableTable> {
  $$CoffeeFavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalUrl => $composableBuilder(
    column: $table.originalUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoffeeFavoritesTableTableAnnotationComposer
    extends Composer<_$CoffeeDatabase, $CoffeeFavoritesTableTable> {
  $$CoffeeFavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalUrl => $composableBuilder(
    column: $table.originalUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CoffeeFavoritesTableTableTableManager
    extends
        RootTableManager<
          _$CoffeeDatabase,
          $CoffeeFavoritesTableTable,
          CoffeeFavoritesTableData,
          $$CoffeeFavoritesTableTableFilterComposer,
          $$CoffeeFavoritesTableTableOrderingComposer,
          $$CoffeeFavoritesTableTableAnnotationComposer,
          $$CoffeeFavoritesTableTableCreateCompanionBuilder,
          $$CoffeeFavoritesTableTableUpdateCompanionBuilder,
          (
            CoffeeFavoritesTableData,
            BaseReferences<
              _$CoffeeDatabase,
              $CoffeeFavoritesTableTable,
              CoffeeFavoritesTableData
            >,
          ),
          CoffeeFavoritesTableData,
          PrefetchHooks Function()
        > {
  $$CoffeeFavoritesTableTableTableManager(
    _$CoffeeDatabase db,
    $CoffeeFavoritesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeFavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeFavoritesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CoffeeFavoritesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> originalUrl = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeFavoritesTableCompanion(
                id: id,
                originalUrl: originalUrl,
                localPath: localPath,
                platform: platform,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String originalUrl,
                Value<String?> localPath = const Value.absent(),
                required String platform,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeeFavoritesTableCompanion.insert(
                id: id,
                originalUrl: originalUrl,
                localPath: localPath,
                platform: platform,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoffeeFavoritesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CoffeeDatabase,
      $CoffeeFavoritesTableTable,
      CoffeeFavoritesTableData,
      $$CoffeeFavoritesTableTableFilterComposer,
      $$CoffeeFavoritesTableTableOrderingComposer,
      $$CoffeeFavoritesTableTableAnnotationComposer,
      $$CoffeeFavoritesTableTableCreateCompanionBuilder,
      $$CoffeeFavoritesTableTableUpdateCompanionBuilder,
      (
        CoffeeFavoritesTableData,
        BaseReferences<
          _$CoffeeDatabase,
          $CoffeeFavoritesTableTable,
          CoffeeFavoritesTableData
        >,
      ),
      CoffeeFavoritesTableData,
      PrefetchHooks Function()
    >;

class $CoffeeDatabaseManager {
  final _$CoffeeDatabase _db;
  $CoffeeDatabaseManager(this._db);
  $$CoffeeFavoritesTableTableTableManager get coffeeFavoritesTable =>
      $$CoffeeFavoritesTableTableTableManager(_db, _db.coffeeFavoritesTable);
}
