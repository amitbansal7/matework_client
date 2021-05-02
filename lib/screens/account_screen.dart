import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  static final routeName = "account";
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Account",
          ),
        ),
      ),
    );
  }
}
