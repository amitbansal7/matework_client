import 'package:Matework/network/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_response.g.dart';

@JsonSerializable()
class InviteResponse {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'created_at')
  final int? createdAt;

  @JsonKey(name: 'user')
  final UserResponse? user;

  InviteResponse({this.id, this.message, this.createdAt, this.user});

  factory InviteResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InviteResponseToJson(this);
}
