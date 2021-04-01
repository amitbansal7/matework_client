import 'package:moor/moor.dart';

class ChatMessages extends Table {
  IntColumn get id => integer()();
  IntColumn get inviteId => integer()();
  IntColumn get senderId => integer()();
  TextColumn get message => text()();
  BoolColumn get sent => boolean()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
