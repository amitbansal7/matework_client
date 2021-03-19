import 'package:Matework/models/invite.dart';
import 'package:Matework/screens/user_chat_screen.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InviteUserTile extends StatelessWidget {
  final Invite invite;
  InviteUserTile({required this.invite});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: MediaQuery.of(context).size.width / 14,
        backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/20418870?s=460&u=257535507e273cdc734928e60132cbd0d6668fda&v=4'),
      ),
      title: Text(
        "${invite.userFirstName} ${invite.userLastName}",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height / 53),
      ),
      subtitle: Text(
        invite.message ?? "",
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      trailing: Wrap(
        spacing:
            MediaQuery.of(context).size.height / 96, // space between two icons
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
        Navigator.of(context).pushNamed(UserProfileScreen.routeName);
      },
    );
  }

  void _acceptInvite(Invite invite, BuildContext context) async {
    final viewModel = Provider.of<InvitesViewModel>(context, listen: false);
    final response = await viewModel.acceptInvite(invite.id!);
    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        message: "Invite Accepted",
        error: false,
      ).getSnackbar());
      Navigator.pushNamed(context, UserChatScreen.routeName,
          arguments: {"userId": invite.userId!});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        message: response,
        error: true,
      ).getSnackbar());
    }
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: Text("Reject Connect Invite"),
      content: Text("Are you sure you want to reject invite?"),
      actions: [
        cancelButton,
        continueButton,
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
