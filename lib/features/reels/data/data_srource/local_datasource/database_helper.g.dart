// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ReelDao? _reelDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `Reel` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `description` TEXT, `reelUrl` TEXT NOT NULL, `thumbnailUrl` TEXT NOT NULL, `totalViews` INTEGER NOT NULL, `totalLikes` INTEGER NOT NULL, `totalComments` INTEGER NOT NULL, `totalShare` INTEGER NOT NULL, `totalWishes` INTEGER NOT NULL, `aspectRatio` TEXT NOT NULL, `isLiked` INTEGER NOT NULL, `isWished` INTEGER NOT NULL, `isFollowed` INTEGER NOT NULL, `language` TEXT, `user` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ReelDao get reelDao {
    return _reelDaoInstance ??= _$ReelDao(database, changeListener);
  }
}

class _$ReelDao extends ReelDao {
  _$ReelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reelInsertionAdapter = InsertionAdapter(
            database,
            'Reel',
            (Reel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'reelUrl': item.reelUrl,
                  'thumbnailUrl': item.thumbnailUrl,
                  'totalViews': item.totalViews,
                  'totalLikes': item.totalLikes,
                  'totalComments': item.totalComments,
                  'totalShare': item.totalShare,
                  'totalWishes': item.totalWishes,
                  'aspectRatio': item.aspectRatio,
                  'isLiked': item.isLiked ? 1 : 0,
                  'isWished': item.isWished ? 1 : 0,
                  'isFollowed': item.isFollowed ? 1 : 0,
                  'language': item.language,
                  'user': _userConverter.encode(item.user)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reel> _reelInsertionAdapter;

  @override
  Future<List<Reel>> findAllReels(int page) async {
    return _queryAdapter.queryList('SELECT * FROM Reel LIMIT 10 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Reel(
            row['id'] as int,
            row['title'] as String,
            row['description'] as String?,
            row['reelUrl'] as String,
            row['thumbnailUrl'] as String,
            row['totalViews'] as int,
            row['totalLikes'] as int,
            row['totalComments'] as int,
            row['totalShare'] as int,
            row['totalWishes'] as int,
            row['aspectRatio'] as String,
            (row['isLiked'] as int) != 0,
            (row['isWished'] as int) != 0,
            (row['isFollowed'] as int) != 0,
            row['language'] as String?,
            _userConverter.decode(row['user'] as String)),
        arguments: [page]);
  }

  @override
  Future<void> insertReel(Reel reel) async {
    await _reelInsertionAdapter.insert(reel, OnConflictStrategy.ignore);
  }
}

// ignore_for_file: unused_element
final _userConverter = UserConverter();
