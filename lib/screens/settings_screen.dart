import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/services/user_data_channel_manager.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:Matework/widgets/page_heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';
import '../utils.dart';
import 'auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myId =
        Provider.of<UserDataChannelManager>(context, listen: false).myId;
    final userProfileViewModel =
        Provider.of<UserProfileViewModel>(context, listen: false);
    final Dio dio = Provider.of<Dio>(context);
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
              ),
              SizedBox(height: 40),
              _buildSettingDivider(),
              _buildSettingItem(
                "Preferences",
                Icons.room_preferences,
                () {},
              ),
              _buildSettingDivider(),
              _buildSettingItem(
                "Account",
                Icons.account_box,
                () {},
              ),
              _buildSettingDivider(),
              _buildSettingItem(
                "Logout",
                Icons.logout,
                () {
                  _logout(dio, context);
                },
              ),
              _buildSettingDivider(),
            ],
          );
        }
      },
    );
  }

  Widget _buildSettingDivider() {
    return Divider(indent: 20, endIndent: 20);
  }

  Widget _buildSettingItem(String title, IconData iconData, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // padding: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 40),
              child: Icon(iconData),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(Dio dio, BuildContext context) async {
    await deleteAllData(dio);
    Navigator.maybePop(context);
    Navigator.popAndPushNamed(context, AuthScreen.routeName);
  }
}
