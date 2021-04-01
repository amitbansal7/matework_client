// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteResponse _$InviteResponseFromJson(Map<String, dynamic> json) {
  return InviteResponse(
    id: json['id'] as int?,
    message: json['message'] as String?,
    createdAt: json['created_at'] as int?,
    user: json['user'] == null
        ? null
        : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InviteResponseToJson(InviteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'created_at': instance.createdAt,
      'user': instance.user,
    };
