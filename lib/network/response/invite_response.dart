import 'package:Matework/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';

part 'invite_response.g.dart';

@entity
@JsonSerializable()
class InviteResponse {
  @primaryKey
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'created_at')
  final int? createdAt;

  @JsonKey(name: 'user')
  final User? user;

  InviteResponse({this.id, this.message, this.createdAt, this.user});

  factory InviteResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InviteResponseToJson(this);
}
