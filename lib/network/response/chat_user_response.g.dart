// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserResponse _$ChatUserResponseFromJson(Map<String, dynamic> json) {
  return ChatUserResponse(
    id: json['id'] as int?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    avatar: json['avatar'] as String?,
    inviteId: json['invite_id'] as int?,
    updatedAt: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$ChatUserResponseToJson(ChatUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'invite_id': instance.inviteId,
      'updated_at': instance.updatedAt,
    };
