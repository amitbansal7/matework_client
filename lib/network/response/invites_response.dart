// @dart=2.9

import 'package:Matework/models/invite.dart';
import 'package:Matework/models/user.dart';
import 'package:Matework/network/response/invite_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invites_response.g.dart';

@JsonSerializable()
class InvitesResponse {
  final List<InviteResponse> invites;

  InvitesResponse({this.invites});

  factory InvitesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvitesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InvitesResponseToJson(this);
}
