import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageHeadingWidget extends StatelessWidget {
  final String title;
  PageHeadingWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.h, left: 20.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25.sp,
          fontFamily: "PlayfairDisplay",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
