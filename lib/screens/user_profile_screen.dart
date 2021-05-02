import 'package:Matework/database.dart';
import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
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
      child: UserProfileScreen(userId: userId),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final int userId;

  UserProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProfileViewModel =
        Provider.of<UserProfileViewModel>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<UserProfile>(
        stream: userProfileViewModel.getUserProfile(userId),
        builder: (context, snapshot) {
          final userProfile = snapshot.data;
          if (userProfile == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(userProfile.firstName ?? ""));
          }
        },
      ),
    );
  }
}
