// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:Matework/database.dart';
import 'package:Matework/main.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/screens/user_profile_screen.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    db.markAllChatMessageSeenByInviteId(chatUser.inviteId);
    // ScrollController _scrollController = new ScrollController();

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });

    return Scaffold(
      appBar: _buildChatDetailPageAppBar(chatUser),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 70.h),
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
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
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
              padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
              height: 50.h,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 14.w),
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
              padding: EdgeInsets.only(right: 15.w, bottom: 7.h),
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
                  size: 20.sp,
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
          padding: EdgeInsets.only(right: 16.w),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black)),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, UserProfileScreenWrapper.routeName,
                      arguments: {"userId": chatUser.id});
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 33.h,
                    imageUrl: chatUser.avatar ?? "",
                    placeholder: (context, url) =>
                        Image.asset("assets/images/avatar_placeholder.png"),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/avatar_placeholder.png"),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, UserProfileScreenWrapper.routeName,
                            arguments: {"userId": chatUser.id});
                      },
                      child: Text(
                        "${chatUser.firstName} ${chatUser.lastName}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5.h)
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
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 7.h, bottom: 7.h),
      child: Align(
        alignment: (message.senderId == chatUser.id
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: (message.senderId == chatUser.id
                  ? Colors.white
                  : Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(11.h),
            child: _buildMessageText(message, message.senderId != chatUser.id)),
      ),
    );
  }
}

Widget _buildMessageText(ChatMessage message, bool imSender) {
  return Wrap(
    children: [
      Text(message.message),
      SizedBox(width: 2.w),
      imSender
          ? Container(
              padding: EdgeInsets.only(top: 2.h),
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
