import 'package:Matework/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';

part 'invite.g.dart';

@entity
@JsonSerializable()
class Invite {
  @primaryKey
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'created_at')
  final int? createdAt;

  final int? userId;
  final String? userFirstName;
  final String? userLastName;
  final String? userAvatar;
  final bool? seen;

  Invite(
      {this.id,
      this.message,
      this.createdAt,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.userAvatar,
      this.seen});

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);
  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
