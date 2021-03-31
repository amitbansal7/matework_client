// @dart=2.9

import 'dart:convert';

import 'package:Matework/main.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/viewmodels/chat_viewmodel.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../utils.dart';
import 'package:bubble/bubble.dart';
import 'package:bubble/issue_clipper.dart';
import 'package:websocket_manager/websocket_manager.dart';

class UserChatScreenWrapper extends StatelessWidget {
  static final String routeName = "/chat";
  final int userId;

  UserChatScreenWrapper({this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider2<ChatsRepository, ChatsRestClient,
            ChatViewModel>(
          create: (_) => ChatViewModel(),
          update: (_, chatsRepository, chatsRestClient, viewModel) {
            viewModel.setChatsRepository = chatsRepository;
            viewModel.setChatsRestClient = chatsRestClient;
            viewModel.userId = userId;
            return viewModel;
          },
        )
      ],
      child: UserChatScreen(),
    );
  }
}

class UserChatScreen extends StatefulWidget {
  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    setupCable();
  }

  void setupCable() async {
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    final socket = WebsocketManager(BASE_SOCKET_URL, {
      AUTHORIZATION: token,
    });
    _connectAndSubscribe(socket);
    socket.onMessage((dynamic message) {
      final Map<String, dynamic> data = json.decode(message);
      if (data["type"] == "ping") {
        return;
      }
      print(message);
      if (data.containsKey("identifier") &&
          json.decode(data["identifier"])["channel"] == "UserDataChannel" &&
          data.containsKey("message") &&
          data["message"]["type"] == "Message") {
        setState(() {
          print("Setting");
          messages.add(data["message"]["message"]);
        });
      }
    });

    socket.onClose((dynamic message) {
      print("Closeddddddd");
      _connectAndSubscribe(socket);
    });
  }

  void _connectAndSubscribe(WebsocketManager socket) {
    socket.connect();
    final data = jsonEncode({
      "command": 'subscribe',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
    });

    socket.send(data);
    print(data);
  }

  static const styleSomebody = BubbleStyle(
    color: Colors.black,
    borderWidth: 3,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    color: Colors.white,
    borderWidth: 3,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
    messages.add("Hey, Im ${chatViewModel.userId.toString()}");
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: messages.length,
          padding: EdgeInsets.only(top: 50, left: 8, bottom: 8, right: 8),
          itemBuilder: (ctx, index) {
            return Bubble(
              style: (index % 2 == 0) ? styleSomebody : styleMe,
              child: Text(
                messages[index],
                style: TextStyle(
                    color: (index % 2 == 0) ? Colors.white : Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
