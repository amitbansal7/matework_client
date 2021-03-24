import 'package:Matework/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';

part 'chat_user.g.dart';

@entity
@JsonSerializable()
class ChatUser {
  @primaryKey
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'invite_id')
  final int? inviteId;

  @JsonKey(name: 'updated_at')
  final int? updatedAt;

  ChatUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.avatar,
      this.inviteId,
      this.updatedAt});

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
