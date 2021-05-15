import 'dart:math';

import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/accept_invite_alert_form.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var rng = new Random();
  int userId = 45;

  @override
  Widget build(BuildContext context) {
    final invitesViewModel =
        Provider.of<InvitesViewModel>(context, listen: false);

    return Stack(
      children: [
        UserProfileScreenWrapper(userId: userId),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.cancel_outlined, size: 40.sp),
                onPressed: () {
                  setState(() {
                    userId = rng.nextInt(170);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.check_circle_outline, size: 40.sp),
                onPressed: () {
                  setState(() {
                    _showCreateInvite(context, userId, invitesViewModel);
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  void _createInvite(
    int toUserId,
    InvitesViewModel invitesViewModel,
    String message,
  ) async {
    final response = await invitesViewModel.createInvite(toUserId, message);
    if (response.item1) {
      setState(() {
        userId = rng.nextInt(170);
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      message: response.item2,
      error: !response.item1,
    ).getSnackbar());
  }

  void _showCreateInvite(
    BuildContext ogContext,
    int toUserId,
    InvitesViewModel invitesViewModel,
  ) async {
    showDialog(
      context: ogContext,
      builder: (BuildContext context) {
        return AcceptInviteAlertForm(
          onSend: (String message) {
            _createInvite(toUserId, invitesViewModel, message);
            Navigator.of(context, rootNavigator: true).pop();
          },
          title: "Message And Send Invite",
          okButtonText: "Send",
        );
      },
    );
  }
}
