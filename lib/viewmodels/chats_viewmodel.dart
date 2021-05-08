// @dart=2.9

import 'package:Matework/converts/chats_converter.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../database.dart';

class ChatsViewModel extends ChangeNotifier {
  static const CHAT_USERS_UPDATE_AT = "ChatUsersFromApiUpdateAt";

  ChatsRestClient chatsRestClient;
  AppDatabase db;
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

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
    final currentTs = DateTime.now().millisecondsSinceEpoch;
    final tsString =
        (await secureStorage.read(key: CHAT_USERS_UPDATE_AT)) ?? "0";
    final updateAt = int.parse(tsString);
    if (updateAt != 0 && updateAt > currentTs) return;
    try {
      final apiResponse = await chatsRestClient?.getAllChatUsers();
      final chatsResponse = apiResponse.data.chats;
      final chats = chatsResponse.map((e) {
        return chatUserResponseToChatUser(e);
      }).toList();

      if (chats != null) {
        db?.deleteAllAndinsertChatUsers(chats);
      }
      final nextUpdateAt =
          DateTime.now().add(Duration(minutes: 15)).millisecondsSinceEpoch;
      secureStorage.write(
          key: CHAT_USERS_UPDATE_AT, value: nextUpdateAt.toString());
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
