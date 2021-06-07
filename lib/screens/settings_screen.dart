import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/services/user_data_channel_manager.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:Matework/widgets/page_heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myId =
        Provider.of<UserDataChannelManager>(context, listen: false).myId;
    final userProfileViewModel =
        Provider.of<UserProfileViewModel>(context, listen: false);
    return StreamBuilder<UserProfile>(
      stream: userProfileViewModel.getUserProfile(myId),
      builder: (context, snapshot) {
        final userProfile = snapshot.data;
        if (userProfile == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              PageHeadingWidget(title: "Settings"),
              SizedBox(height: 15),
              ClipOval(
                child: CachedNetworkImage(
                  height: 120.h,
                  imageUrl: userProfile.avatar ?? "",
                  placeholder: (context, url) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/avatar_placeholder.png"),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "${userProfile.firstName} ${userProfile.lastName}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, UserProfileScreenWrapper.routeName,
                          arguments: {"userId": userProfile.id});
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 50),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }
}
