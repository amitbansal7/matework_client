import 'dart:convert';

import 'package:Matework/main.dart';
import 'package:action_cable/action_cable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../utils.dart';
import 'package:websocket_manager/websocket_manager.dart';

class UserChatScreen extends StatefulWidget {
  static final String routeName = "/chat";

  final int userId;

  UserChatScreen({required this.userId});

  @override
  _UserChatScreenState createState() => _UserChatScreenState(userId: userId);
}

class _UserChatScreenState extends State<UserChatScreen> {
  final int userId;
  _UserChatScreenState({required this.userId});

  List<String> messages = [];
  @override
  void initState() {
    super.initState();
    setupCable();
  }

  void setupCable() async {
    // final cable = Provider.of<ActionCable>(context, listen: false);
    // cable.subscribe(
    //   "UserDataChannel", // either "Chat" and "ChatChannel" is fine
    //   channelParams: {"id": 4},
    //   onSubscribed: () {}, // `confirm_subscription` received
    //   onDisconnected: () {}, // `disconnect` received
    //   onMessage: (Map message) {
    //     print(message);
    //     setState(
    //       () {
    //         messages.add(message["message"]);
    //       },
    //     );
    //   },
    // );
    // final dio = Provider.of<Dio>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (ctx, index) {
            return Text(messages[index]);
          },
        ),
      ),
    );
  }
}
