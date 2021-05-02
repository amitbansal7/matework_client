import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database.dart';

class UserProfileWidget extends StatelessWidget {
  final int userId;

  UserProfileWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProfileViewModel =
        Provider.of<UserProfileViewModel>(context, listen: false);
    return StreamBuilder<UserProfile>(
      stream: userProfileViewModel.getUserProfile(userId),
      builder: (context, snapshot) {
        final userProfile = snapshot.data;
        if (userProfile == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text(userProfile.firstName ?? ""));
        }
      },
    );
  }
}
