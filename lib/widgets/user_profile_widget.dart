import 'dart:convert';

import 'package:Matework/network/response/skill_dao.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:Matework/widgets/page_heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  _buildInfoCard(userProfile),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 20),
              _buildSkills(userProfile),
            ],
          );
        }
      },
    );
  }

  Widget _buildInfoCard(UserProfile userProfile) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            _buildShortBio(userProfile),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 0.1,
                width: 200.sp,
                color: Colors.black,
              ),
            ),
            _buildExternalLink(userProfile),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 0.1,
                width: 200.sp,
                color: Colors.black,
              ),
            ),
            _buildInfoScroll(userProfile),
          ],
        ),
      ),
    );
  }

  Widget _buildSkills(UserProfile userProfile) {
    final skillsJson = json.decode(userProfile.skills ?? "[]");
    List<SkillDao> skills = List<SkillDao>.from(
      skillsJson.map((skill) => SkillDao.fromJson(skill)),
    );
    skills.sort((a, b) => b.rating.compareTo(a.rating));

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Skills",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.all(3),
          ),
          SizedBox(
            height: 42.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: skills.length,
              itemBuilder: (BuildContext context, int idx) {
                final skill = skills[idx];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      "${skill.name} • ${skill.rating}",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExternalLink(UserProfile userProfile) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 200.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.link),
          SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                userProfile.externalLink ?? "",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShortBio(UserProfile userProfile) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 200.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.how_to_reg_sharp),
          SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(userProfile.shortBio ?? "",
                  style: TextStyle(fontSize: 13.sp)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoScroll(UserProfile userProfile) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 200.w,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.calendar_today_rounded, size: 12.sp),
            Padding(padding: EdgeInsets.all(2)),
            Text(userProfile.age.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(height: 20, width: 0.1.sp, color: Colors.black),
            ),
            Icon(Icons.calendar_today_rounded, size: 12.sp),
            Padding(padding: EdgeInsets.all(2)),
            Text(userProfile.experience.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(height: 20, width: 0.1.sp, color: Colors.black),
            ),
            Icon(Icons.location_on_sharp, size: 12.sp),
            Padding(padding: EdgeInsets.all(2)),
            Text(userProfile.location.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(height: 20, width: 0.1.sp, color: Colors.black),
            ),
            Text(userProfile.age.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(height: 20, width: 0.1.sp, color: Colors.black),
            ),
            Text(userProfile.location.toString()),
          ],
        ),
      ),
    );
  }
}
