import 'package:json_annotation/json_annotation.dart';

part 'chat_user_response.g.dart';

@JsonSerializable()
class ChatUserResponse {
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

  ChatUserResponse(
      {this.id,
      this.firstName,
      this.lastName,
      this.avatar,
      this.inviteId,
      this.updatedAt});

  factory ChatUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserResponseToJson(this);
}
