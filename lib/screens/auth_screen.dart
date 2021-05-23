import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/viewmodels/auth_viewmodel.dart';
import 'package:Matework/widgets/auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import '../utils.dart';

class AuthScreen extends StatelessWidget {
  static final routeName = "/";
  final authToken =
      FlutterSecureStorage().read(key: AUTHORIZATION).then((value) => value!);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: authToken,
      builder: (context, token) {
        if (token.connectionState == ConnectionState.done) {
          return Scaffold(body: AuthWidget());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
