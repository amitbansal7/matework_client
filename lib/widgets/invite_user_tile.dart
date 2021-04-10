import 'package:Matework/models/invite.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database.dart';

class InviteUserTile extends StatelessWidget {
  final Invite invite;
  InviteUserTile({required this.invite});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          height: 33.h,
          imageUrl: invite.userAvatar ?? "",
          placeholder: (context, url) =>
              Image.asset("assets/images/avatar_placeholder.png"),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/avatar_placeholder.png"),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 7.h, top: 7.h),
            child: Text(
              "${invite.userFirstName} ${invite.userLastName}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
          ),
          SizedBox(width: 8.w),
          if (!invite.seen) Icon(Icons.star, color: Colors.blue)
        ],
      ),
      subtitle: Text(
        invite.message ?? "",
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
      ),
      trailing: Wrap(
        spacing: 18.w, // space between two icons
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: Colors.green),
            onPressed: () {
              _acceptInvite(invite, context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.cancel_outlined, color: Colors.red),
            onPressed: () {
              showAlertDialog(context);
            },
          )
        ],
      ),
      onTap: () {
        Provider.of<InvitesViewModel>(context, listen: false)
            .markAsSeen(invite.id);
        Navigator.of(context).pushNamed(UserProfileScreen.routeName);
      },
    );
  }

  void _acceptInvite(Invite invite, BuildContext context) async {
    final viewModel = Provider.of<InvitesViewModel>(context, listen: false);
    final response = await viewModel.acceptInvite(invite.id);
    if (response.item1) {
      // Navigator.pushNamed(context, UserChatScreenWrapper.routeName,
      //     arguments: {"inviteId": invite.id});
    }
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      message: response.item2,
      error: !response.item1,
    ).getSnackbar());
  }

  void _deleteInvite(Invite invite, BuildContext context) async {
    final viewModel = Provider.of<InvitesViewModel>(context, listen: false);
    final response = await viewModel.deleteInvite(invite.id);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      message: response.item2,
      error: !response.item1,
    ).getSnackbar());
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Reject Connect Invite"),
      content: Text("Are you sure you want to reject invite?"),
      actions: [
        TextButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        TextButton(
          child: Text("Yes"),
          onPressed: () {
            _deleteInvite(invite, context);
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
