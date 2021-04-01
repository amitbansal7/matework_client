import 'package:Matework/database.dart';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatViewModel extends ChangeNotifier {
  AppDatabase? db;
  ChatsRestClient? chatsRestClient;
  int? userId;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
  }

  set setUserId(int userId) {
    this.userId = userId;
  }

  set setChatsRestClient(ChatsRestClient chatsRestClient) {
    this.chatsRestClient = chatsRestClient;
  }
}
