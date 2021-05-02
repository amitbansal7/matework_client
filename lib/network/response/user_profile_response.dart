import 'package:Matework/models/invite.dart';
import 'package:Matework/network/response/invite_response.dart';
import 'package:Matework/network/response/user_profile_dao.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final UserProfileDao profile;

  UserProfileResponse({required this.profile});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
