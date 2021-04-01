import 'package:Matework/database.dart';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatViewModel extends ChangeNotifier {
  late AppDatabase db;
  late ChatsRestClient chatsRestClient;
  late int _chatUserId;
  late ChatUser chatUser;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
  }

  set chatUserId(int chatUserId) {
    this._chatUserId = chatUserId;
    // _getChatUser();
  }

  Future<ChatUser> getChatUser() async {
    return db.findChatUserById(_chatUserId);
    // print(this.chatUser);
  }

  set setChatsRestClient(ChatsRestClient chatsRestClient) {
    this.chatsRestClient = chatsRestClient;
  }
}
