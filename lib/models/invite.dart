import 'package:json_annotation/json_annotation.dart';
import 'package:moor/moor.dart';

// part 'invite.g.dart';

class Invites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get message => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get userId => integer().nullable()();
  TextColumn get userFirstName => text().nullable()();
  TextColumn get userLastName => text().nullable()();
  TextColumn get userAvatar => text().nullable()();
  BoolColumn get seen => boolean()();
}

// @entity
// @JsonSerializable()
// class Invite {
//   @primaryKey
//   @JsonKey(name: 'id')
//   final int? id;

//   @JsonKey(name: 'message')
//   final String? message;

//   @JsonKey(name: 'created_at')
//   final int? createdAt;

//   final int? userId;
//   final String? userFirstName;
//   final String? userLastName;
//   final String? userAvatar;
//   final bool? seen;

//   Invite(
//       {this.id,
//       this.message,
//       this.createdAt,
//       this.userId,
//       this.userFirstName,
//       this.userLastName,
//       this.userAvatar,
//       this.seen});

//   factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);
//   Map<String, dynamic> toJson() => _$InviteToJson(this);
// }
