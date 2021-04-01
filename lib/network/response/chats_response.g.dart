// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsResponse _$ChatsResponseFromJson(Map<String, dynamic> json) {
  return ChatsResponse(
    chats: (json['chats'] as List<dynamic>)
        .map((e) => ChatUserResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChatsResponseToJson(ChatsResponse instance) =>
    <String, dynamic>{
      'chats': instance.chats,
    };
