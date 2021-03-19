import 'package:Matework/database.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/invites_response.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/invite_user_tile.dart';
import 'package:Matework/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvitesScreen extends StatefulWidget {
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<InvitesScreen> {
  void initState() {
    super.initState();
    Provider.of<InvitesViewModel>(context, listen: false).getAllInvites();
  }

  @override
  Widget build(BuildContext context) {
    final invitesViewModel = Provider.of<InvitesViewModel>(context);

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _buildInvitesHeading(),
        ),
        Expanded(
          flex: 13,
          child: (invitesViewModel.invites.isNotEmpty)
              ? _buildInvitesList(invitesViewModel.invites)
              : invitesViewModel.checkedFromApi
                  ? Center(child: const Text("No Invites"))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ],
    );
  }

  Widget _buildInvitesHeading() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
      child: Text(
        "Invites",
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height / 20,
          fontFamily: "PlayfairDisplay",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInvitesList(List<Invite> invites) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 0.6,
          endIndent: MediaQuery.of(context).size.width / 13,
          indent: MediaQuery.of(context).size.width / 5.5,
        );
      },
      itemCount: invites.length,
      itemBuilder: (ctx, idx) {
        final invite = invites[idx];
        return InviteUserTile(invite: invite);
      },
    );
  }
}
