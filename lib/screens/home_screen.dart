import 'package:Matework/network/auth_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = "home";
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<AuthRestClient>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME SCREEN"),
            TextButton(
              child: Text("GOTO details"),
              onPressed: () {
                // Navigator.pushNamed(context, DetailScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
