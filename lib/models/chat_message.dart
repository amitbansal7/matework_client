import 'package:moor/moor.dart';

class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId => integer().nullable()();
  IntColumn get inviteId => integer()();
  IntColumn get senderId => integer()();
  TextColumn get message => text()();
  BoolColumn get sent => boolean()();
  BoolColumn get seen => boolean()();
  IntColumn get createdAt => integer()();

  // @override
  // List<String> get customConstraints => ['UNIQUE (serverId)'];
}
