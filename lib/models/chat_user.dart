import 'package:moor/moor.dart';

class ChatUsers extends Table {
  IntColumn get id => integer()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get avatar => text().nullable()();
  IntColumn get inviteId => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
