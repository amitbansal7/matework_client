import 'package:Matework/models/chat_user.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatsViewModel extends ChangeNotifier {
  ChatsRepository? chatsRepository;
  ChatsRestClient? chatsRestClient;
  List<ChatUser> _chatUsers = [];

  bool _checkedFromApi = false;

  bool get checkedFromApi => _checkedFromApi;

  List<ChatUser> get chatUsers => _chatUsers;

  set setChatsRepository(ChatsRepository repository) {
    this.chatsRepository = repository;
  }

  set setChatsRestClient(ChatsRestClient chatsRestClient) {
    this.chatsRestClient = chatsRestClient;
  }

  void getAllChatUsers() async {
    print("EHRE");
    _chatUsers = await chatsRepository!.findChatUsers();
    notifyListeners();
    getChatUsersFromApi();
  }

  void getChatUsersFromApi() async {
    try {
      final chatUsers = await chatsRestClient?.getAllChatUsers();
      chatsRepository?.deleteAllChatUsers();
      chatUsers?.data?.chats?.forEach((chatUser) {
        chatsRepository!.insertChatUser(chatUser);
      });
      _chatUsers = await chatsRepository!.findChatUsers();
    } on DioError catch (e) {}
    _checkedFromApi = true;
    notifyListeners();
  }
}
