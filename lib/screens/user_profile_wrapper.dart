import 'package:Matework/database.dart';
import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:Matework/widgets/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreenWrapper extends StatelessWidget {
  static final routeName = "user_profile";
  final int userId;

  UserProfileScreenWrapper({required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider2<AppDatabase, UserProfilesRestClient,
            UserProfileViewModel>(
          create: (_) => UserProfileViewModel(),
          update: (_, db, userProfilesRestClient, viewModel) {
            viewModel!.userProfilesRestClient = userProfilesRestClient;
            viewModel.setAppDatabase = db;
            return viewModel;
          },
        )
      ],
      child: Scaffold(
        body: UserProfileWidget(userId: userId),
      ),
    );
  }
}
