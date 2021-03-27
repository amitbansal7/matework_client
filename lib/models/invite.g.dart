// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) {
  return Invite(
    id: json['id'] as int,
    message: json['message'] as String,
    createdAt: json['created_at'] as int,
    userId: json['userId'] as int,
    userFirstName: json['userFirstName'] as String,
    userLastName: json['userLastName'] as String,
    userAvatar: json['userAvatar'] as String,
    seen: json['seen'] as bool,
  );
}

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'created_at': instance.createdAt,
      'userId': instance.userId,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userAvatar': instance.userAvatar,
      'seen': instance.seen,
    };
