import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:Matework/widgets/page_heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          return Column(
            children: [
              PageHeadingWidget(
                  title: "${userProfile.firstName} ${userProfile.lastName}"),
              SizedBox(height: 10),
              ClipOval(
                child: CachedNetworkImage(
                  height: 93.h,
                  imageUrl: userProfile.avatar ?? "",
                  placeholder: (context, url) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                ),
              ),
              SizedBox(height: 10),
              Text(userProfile.longBio ?? ""),
              SizedBox(height: 10),
            ],
          );
        }
      },
    );
  }
}
