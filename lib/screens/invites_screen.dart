import 'package:Matework/database.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/invites_response.dart';
import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/invite_user_card.dart';
import 'package:Matework/widgets/page_heading_widget.dart';
import 'package:Matework/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitesScreen extends StatefulWidget {
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<InvitesScreen> {
  void initState() {
    super.initState();
    Provider.of<InvitesViewModel>(context, listen: false).getInvitesFromApi();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InvitesViewModel>(context, listen: false);
    return Column(
      children: [
        PageHeadingWidget(title: "Invites"),
        SizedBox(height: 5),
        StreamBuilder<List<Invite>>(
          stream: viewModel.getInvites,
          builder: (context, snapshot) {
            final invites = snapshot.data;
            if (invites == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                flex: 13,
                child: (invites.isNotEmpty)
                    ? _buildInvitesList(invites)
                    : Center(
                        child: Text("No Invites"),
                      ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildInvitesList(List<Invite> invites) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: invites.length,
      itemBuilder: (ctx, idx) {
        final invite = invites[idx];
        return Container(
          padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserProfileScreenWrapper.routeName,
                  arguments: {"userId": invite.userId});
            },
            child: InviteUserCard(invite: invite),
          ),
        );
      },
    );
  }
}
