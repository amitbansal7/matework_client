// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:Matework/database.dart';
import 'package:Matework/main.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/services/user_data_channel_manager.dart';
import 'package:Matework/viewmodels/chat_viewmodel.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../utils.dart';
import 'package:bubble/bubble.dart';
import 'package:bubble/issue_clipper.dart';
import 'package:websocket_manager/websocket_manager.dart';

class UserChatScreenWrapper extends StatelessWidget {
  static final String routeName = "/chat";
  final int chatUserId;

  UserChatScreenWrapper({this.chatUserId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider2<AppDatabase, ChatsRestClient,
            ChatViewModel>(
          create: (_) => ChatViewModel(),
          update: (_, db, chatsRestClient, viewModel) {
            viewModel.setAppDatabase = db;
            viewModel.setChatsRestClient = chatsRestClient;
            viewModel.chatUserId = chatUserId;
            return viewModel;
          },
        )
      ],
      child: UserChatScreen(),
    );
  }
}

class UserChatScreen extends StatefulWidget {
  UserChatScreen();

  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);

    return FutureBuilder<ChatUser>(
      future: chatViewModel.getChatUser(),
      builder: (context, chatUserFuture) {
        if (chatUserFuture.connectionState == ConnectionState.done) {
          return _createScaffold(context, chatUserFuture.data);
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _createScaffold(BuildContext context, ChatUser chatUser) {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final messageController = TextEditingController();
    int myId;

    // ScrollController _scrollController = new ScrollController();

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });

    return Scaffold(
      appBar: _buildChatDetailPageAppBar(chatUser),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 70),
            child: StreamBuilder<List<ChatMessage>>(
              stream: db.watchAllMessagesById(chatUser.inviteId),
              builder: (context, snapshot) {
                final messages = snapshot.data;
                if (messages == null) {
                  return SizedBox.shrink();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildChatBubble(messages[index], chatUser);
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30, bottom: 15),
              child: FloatingActionButton(
                onPressed: () async {
                  final text = messageController.text.trim();
                  if (text.isNotEmpty) {
                    if (myId == null) {
                      myId = Provider.of<UserDataChannelManager>(context,
                              listen: false)
                          .myId;
                    }
                    db.insertChatMessage(
                      ChatMessagesCompanion(
                        message: Value(messageController.text.toString()),
                        inviteId: Value(chatUser.inviteId),
                        createdAt: Value(
                            DateTime.now().millisecondsSinceEpoch ~/ 1000),
                        senderId: Value(myId),
                        sent: Value(false),
                        seen: Value(true),
                      ),
                    );
                    messageController.clear();
                  }
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildChatDetailPageAppBar(ChatUser chatUser) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black)),
              SizedBox(width: 2),
              CircleAvatar(
                maxRadius: 20,
                child: CachedNetworkImage(
                  imageUrl: chatUser.avatar ?? "",
                  placeholder: (context, url) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                ),
              ),
              // CircleAvatar(
              //     backgroundImage: AssetImage("images/userImage1.jpeg"),
              //     maxRadius: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${chatUser.firstName} ${chatUser.lastName}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: Colors.grey.shade700),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message, ChatUser chatUser) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: (message.senderId == chatUser.id
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: (message.senderId == chatUser.id
                  ? Colors.white
                  : Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(16),
            child: _buildMessageText(message, message.senderId != chatUser.id)),
      ),
    );
  }
}

Widget _buildMessageText(ChatMessage message, bool imSender) {
  return Wrap(
    children: [
      Text(message.message),
      SizedBox(width: 2),
      imSender
          ? Container(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                message.sent ? Icons.check : Icons.timer,
                size: 12,
                color: Colors.grey,
              ),
            )
          : SizedBox.shrink()
    ],
  );
}
