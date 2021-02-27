import 'package:flutter/material.dart';

class MySnackBar {
  final bool error;
  final String message;
  MySnackBar({this.message, this.error = true});

  SnackBar getSnackbar() {
    return SnackBar(
      content: Text(message),
      elevation: 2,
      // margin: EdgeInsetsGeometry.infinity,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
