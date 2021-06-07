import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySnackBar {
  final bool error;
  final String? message;
  MySnackBar({this.message, this.error = true});

  SnackBar getSnackbar() {
    return SnackBar(
      content: Text(message ?? ""),
      elevation: 2,
      margin: EdgeInsets.only(bottom: 60),
      // margin: EdgeInsetsGeometry.infinity,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 500),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      backgroundColor: error ? Colors.red : Colors.green,
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );
  }
}
