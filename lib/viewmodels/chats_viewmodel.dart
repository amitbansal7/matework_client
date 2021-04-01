// @dart=2.9

import 'package:Matework/network/chats_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../database.dart';

class ChatsViewModel extends ChangeNotifier {
  ChatsRestClient chatsRestClient;
  AppDatabase db;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
    _chatUsers = db.watchAllChatUsers();
  }

  Stream<List<ChatUser>> _chatUsers;
  Stream<List<ChatUser>> get getChatUsers => _chatUsers;

  set setChatsRestClient(ChatsRestClient chatsRestClient) {
    this.chatsRestClient = chatsRestClient;
  }

  void getChatUsersFromApi() async {
    try {
      final apiResponse = await chatsRestClient?.getAllChatUsers();
      final chatsResponse = apiResponse.data.chats;
      final chats = chatsResponse.map((e) {
        return ChatUser(
          id: e.id,
          updatedAt: e.updatedAt,
          firstName: e.firstName,
          lastName: e.lastName,
          avatar: e.avatar,
          inviteId: e.inviteId,
        );
      }).toList();

      if (chats != null) {
        db?.deleteAllAndinsertChatUsers(chats);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
