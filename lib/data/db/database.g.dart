// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAssetDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AssetDatabaseBuilder databaseBuilder(String name) =>
      _$AssetDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AssetDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AssetDatabaseBuilder(null);
}

class _$AssetDatabaseBuilder {
  _$AssetDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AssetDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AssetDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AssetDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AssetDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AssetDatabase extends AssetDatabase {
  _$AssetDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AssetDao? _assetDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `asset` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category_id` INTEGER, `name` TEXT, `capital` INTEGER, `profit` INTEGER, `profitPercent` REAL, FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `image` TEXT, `color` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AssetDao get assetDao {
    return _assetDaoInstance ??= _$AssetDao(database, changeListener);
  }
}

class _$AssetDao extends AssetDao {
  _$AssetDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'color': item.color
                }),
        _assetInsertionAdapter = InsertionAdapter(
            database,
            'asset',
            (Asset item) => <String, Object?>{
                  'id': item.id,
                  'category_id': item.categoryId,
                  'name': item.name,
                  'capital': item.capital,
                  'profit': item.profit,
                  'profitPercent': item.profitPercent
                }),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'color': item.color
                }),
        _assetUpdateAdapter = UpdateAdapter(
            database,
            'asset',
            ['id'],
            (Asset item) => <String, Object?>{
                  'id': item.id,
                  'category_id': item.categoryId,
                  'name': item.name,
                  'capital': item.capital,
                  'profit': item.profit,
                  'profitPercent': item.profitPercent
                }),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'color': item.color
                }),
        _assetDeletionAdapter = DeletionAdapter(
            database,
            'asset',
            ['id'],
            (Asset item) => <String, Object?>{
                  'id': item.id,
                  'category_id': item.categoryId,
                  'name': item.name,
                  'capital': item.capital,
                  'profit': item.profit,
                  'profitPercent': item.profitPercent
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final InsertionAdapter<Asset> _assetInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final UpdateAdapter<Asset> _assetUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  final DeletionAdapter<Asset> _assetDeletionAdapter;

  @override
  Future<List<Category>> findAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => Category(
            row['id'] as int?,
            row['name'] as String?,
            row['image'] as String?,
            row['color'] as String?));
  }

  @override
  Future<List<Asset>> findAllAssetWithCategoryId(int categoryId) async {
    return _queryAdapter.queryList('SELECT * FROM asset WHERE category_id = ?1',
        mapper: (Map<String, Object?> row) => Asset(
            row['id'] as int?,
            row['category_id'] as int?,
            row['name'] as String?,
            row['capital'] as int?,
            row['profit'] as int?,
            row['profitPercent'] as double?),
        arguments: [categoryId]);
  }

  @override
  Future<void> deleteAllAssetWithCategoryId(int categoryId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM asset WHERE category_id = ?1',
        arguments: [categoryId]);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAsset(Asset asset) async {
    await _assetInsertionAdapter.insert(asset, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _categoryUpdateAdapter.update(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAsset(Asset asset) async {
    await _assetUpdateAdapter.update(asset, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategory(Category category) async {
    await _categoryDeletionAdapter.delete(category);
  }

  @override
  Future<void> deleteAsset(Asset asset) async {
    await _assetDeletionAdapter.delete(asset);
  }
}
