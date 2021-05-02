import 'package:moor/moor.dart';

class UserProfiles extends Table {
  IntColumn get id => integer()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get avatar => text().nullable()();
  TextColumn get shortBio => text().nullable()();
  TextColumn get lookingFor => text().nullable()();
  TextColumn get longBio => text().nullable()();
  RealColumn get experience => real().nullable()();
  IntColumn get age => integer().nullable()();
  TextColumn get externalLink => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get skills => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
