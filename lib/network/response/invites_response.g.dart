// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesResponse _$InvitesResponseFromJson(Map<String, dynamic> json) {
  return InvitesResponse(
    invites: (json['invites'] as List<dynamic>)
        .map((e) => InviteResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$InvitesResponseToJson(InvitesResponse instance) =>
    <String, dynamic>{
      'invites': instance.invites,
    };
