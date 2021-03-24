// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'chats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsResponse _$ChatsResponseFromJson(Map<String, dynamic> json) {
  return ChatsResponse(
    chats: (json['chats'] as List)
        ?.map((e) =>
            e == null ? null : ChatUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatsResponseToJson(ChatsResponse instance) =>
    <String, dynamic>{
      'chats': instance.chats,
    };
