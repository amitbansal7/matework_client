import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  static final routeName = "user";
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "User Profile",
          ),
        ),
      ),
    );
  }
}
