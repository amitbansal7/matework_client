import 'package:Matework/models/chat_user.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../database.dart';

class ChatUserTile extends StatelessWidget {
  final ChatUser chatUser;
  ChatUserTile({required this.chatUser});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: chatUser.avatar ?? "",
          placeholder: (context, url) =>
              Image.asset("assets/images/avatar_placeholder.png"),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/avatar_placeholder.png"),
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${chatUser.firstName} ${chatUser.lastName}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height / 53),
            ),
            Text(
              timeago.format(new DateTime.fromMillisecondsSinceEpoch(
                  chatUser.updatedAt * 1000)),
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ),
      subtitle: Text(
        "Hey whats up?",
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.pushNamed(context, UserChatScreenWrapper.routeName,
            arguments: {"userId": chatUser.id});
      },
    );
  }
}
