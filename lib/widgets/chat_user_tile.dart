import 'package:Matework/models/chat_user.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';

class ChatUserTile extends StatelessWidget {
  final ChatUser chatUser;
  ChatUserTile({required this.chatUser});
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: false);
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          height: 33.h,
          imageUrl: chatUser.avatar ?? "",
          placeholder: (context, url) =>
              Image.asset("assets/images/avatar_placeholder.png"),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/avatar_placeholder.png"),
        ),
      ),
      title: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(bottom: 7.h, top: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${chatUser.firstName} ${chatUser.lastName}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              Text(
                timeago.format(new DateTime.fromMillisecondsSinceEpoch(
                    chatUser.updatedAt * 1000)),
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          ),
        ),
      ),
      subtitle: FutureBuilder<ChatMessage>(
        future: db.getLastChatMessageByInviteId(chatUser.inviteId),
        builder: (context, lastMessageF) {
          if (lastMessageF.connectionState == ConnectionState.done) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    lastMessageF.data?.message ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ),
                StreamBuilder(
                  stream:
                      db.countUnseenChatMessageByInviteId(chatUser.inviteId),
                  builder: (context, unseenCount) {
                    if (unseenCount.data != null) {
                      if (unseenCount.data == 0) {
                        return SizedBox.shrink();
                      } else {
                        return Container(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Badge(
                            animationType: BadgeAnimationType.fade,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.green,
                            borderRadius: BorderRadius.circular(8.r),
                            badgeContent: Text('${unseenCount.data}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp)),
                          ),
                        );
                      }
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            );
          } else {
            return Text("");
          }
        },
      ),
      onTap: () {
        Navigator.pushNamed(context, UserChatScreenWrapper.routeName,
            arguments: {"chatUserId": chatUser.id});
      },
    );
  }
}
