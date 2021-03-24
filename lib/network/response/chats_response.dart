// @dart=2.9

import 'package:Matework/models/chat_user.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/models/user.dart';
import 'package:Matework/network/response/invite_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chats_response.g.dart';

@JsonSerializable()
class ChatsResponse {
  final List<ChatUser> chats;

  ChatsResponse({this.chats});

  factory ChatsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsResponseToJson(this);
}
