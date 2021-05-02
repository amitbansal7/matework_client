import 'package:Matework/database.dart';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/viewmodels/chat_viewmodel.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:Matework/widgets/chat_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    Provider.of<ChatsViewModel>(context, listen: false).getChatUsersFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatsViewModel>(context, listen: false);
    return Column(
      children: [
        _buildChatsHeading(),
        SizedBox(height: 5),
        StreamBuilder<List<ChatUser>>(
          stream: viewModel.getChatUsers,
          builder: (context, snapshot) {
            final invites = snapshot.data;
            if (invites == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                flex: 13,
                child: (invites.isNotEmpty)
                    ? _buildChatUsersList(invites)
                    : Center(
                        child: Text("No Chats"),
                      ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildChatsHeading() {
    return Container(
      padding: EdgeInsets.only(top: 30.h, left: 20.w),
      alignment: Alignment.topLeft,
      child: Text(
        "Connections",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontFamily: "PlayfairDisplay",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildChatUsersList(List<ChatUser> chatUsers) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 0.6,
          endIndent: 25.w,
          indent: 60.w,
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
