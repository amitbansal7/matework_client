import 'package:json_annotation/json_annotation.dart';
import 'package:moor/moor.dart';

class Invites extends Table {
  IntColumn get id => integer()();
  TextColumn get message => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get userId => integer().nullable()();
  TextColumn get userFirstName => text().nullable()();
  TextColumn get userLastName => text().nullable()();
  TextColumn get userAvatar => text().nullable()();
  TextColumn get userShortBio => text().nullable()();
  BoolColumn get seen => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
