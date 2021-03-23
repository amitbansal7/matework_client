// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  InviteRepository _inviteRepositoryInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Invite` (`id` INTEGER, `message` TEXT, `createdAt` INTEGER, `userId` INTEGER, `userFirstName` TEXT, `userLastName` TEXT, `userAvatar` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  InviteRepository get inviteRepository {
    return _inviteRepositoryInstance ??=
        _$InviteRepository(database, changeListener);
  }
}

class _$InviteRepository extends InviteRepository {
  _$InviteRepository(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _inviteInsertionAdapter = InsertionAdapter(
            database,
            'Invite',
            (Invite item) => <String, dynamic>{
                  'id': item.id,
                  'message': item.message,
                  'createdAt': item.createdAt,
                  'userId': item.userId,
                  'userFirstName': item.userFirstName,
                  'userLastName': item.userLastName,
                  'userAvatar': item.userAvatar
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Invite> _inviteInsertionAdapter;

  @override
  Future<List<Invite>> findAllInvites() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Invite ORDER BY createdAt DESC',
        mapper: (Map<String, dynamic> row) => Invite(
            id: row['id'] as int,
            message: row['message'] as String,
            createdAt: row['createdAt'] as int,
            userId: row['userId'] as int,
            userFirstName: row['userFirstName'] as String,
            userLastName: row['userLastName'] as String,
            userAvatar: row['userAvatar'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Invite');
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Invite where id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertInvite(Invite invite) async {
    await _inviteInsertionAdapter.insert(invite, OnConflictStrategy.abort);
  }
}
