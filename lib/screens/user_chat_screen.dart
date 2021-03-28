import 'package:Matework/main.dart';
import 'package:action_cable/action_cable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../utils.dart';

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
    final cable = Provider.of<ActionCable>(context, listen: false);
    cable.subscribe("InviteChannel", // either "Chat" and "ChatChannel" is fine
        channelParams: {"id": 4},
        onSubscribed: () {}, // `confirm_subscription` received
        onDisconnected: () {}, // `disconnect` received
        onMessage: (Map message) {
      print(message);
      setState(() {
        messages.add(message["message"]);
      });
    } // any other message received
        );
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
