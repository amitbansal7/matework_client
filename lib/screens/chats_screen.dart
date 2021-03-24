import 'package:Matework/models/chat_user.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:Matework/widgets/chat_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    Provider.of<ChatsViewModel>(context, listen: false).getAllChatUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatsViewModel = Provider.of<ChatsViewModel>(context, listen: true);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _buildChatsHeading(),
        ),
        Expanded(
          flex: 13,
          child: (chatsViewModel.chatUsers.isNotEmpty)
              ? _buildInvitesList(chatsViewModel.chatUsers)
              : chatsViewModel.checkedFromApi
                  ? Center(child: const Text("No Connections"))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ],
    );
  }

  Widget _buildChatsHeading() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
      child: Text(
        "Connections",
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height / 20,
          fontFamily: "PlayfairDisplay",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInvitesList(List<ChatUser> chatUsers) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 0.6,
          endIndent: MediaQuery.of(context).size.width / 13,
          indent: MediaQuery.of(context).size.width / 5.5,
        );
      },
      itemCount: chatUsers.length,
      itemBuilder: (ctx, idx) {
        final chatUser = chatUsers[idx];
        return ChatUserTile(chatUser: chatUser);
      },
    );
  }
}
