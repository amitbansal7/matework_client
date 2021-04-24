import 'package:Matework/models/invite.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../database.dart';

class InviteUserTile extends StatelessWidget {
  final Invite invite;
  InviteUserTile({required this.invite});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      height: 63.h,
                      imageUrl: invite.userAvatar ?? "",
                      placeholder: (context, url) =>
                          Image.asset("assets/images/avatar_placeholder.png"),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/avatar_placeholder.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Container(
                    height: 50,
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${invite.userFirstName} ${invite.userLastName}",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Container(
                        height: 0.1,
                        width: 150.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${invite.userShortBio}",
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            Container(
              constraints: BoxConstraints(
                minHeight: 40.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F5F8),
                border: Border.all(
                  color: const Color(0xFFCDCFD2),
                  width: 2.0,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ReadMoreText(
                  invite.message ?? "",
                  trimLines: 2,
                  style: TextStyle(color: Colors.black),
                  colorClickableText: Colors.black,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  lessStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  moreStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _acceptInvite(invite, context);
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
      title: Text("Delete Connect Invite"),
      content: Text("Are you sure you want to delete invite?"),
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
