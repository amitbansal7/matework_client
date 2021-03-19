import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chatting with User > $userId"),
      ),
    );
  }
}
