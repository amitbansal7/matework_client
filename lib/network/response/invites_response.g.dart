// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'invites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesResponse _$InvitesResponseFromJson(Map<String, dynamic> json) {
  return InvitesResponse(
    invites: (json['invites'] as List)
        ?.map((e) => e == null
            ? null
            : InviteResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InvitesResponseToJson(InvitesResponse instance) =>
    <String, dynamic>{
      'invites': instance.invites,
    };
