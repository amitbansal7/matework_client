// @dart=2.9

import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../network/response/auth_response.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<AuthRestClient>(context, listen: false);
    final dio = Provider.of<Dio>(context);
    final storage = FlutterSecureStorage();
    return FutureBuilder<ApiResponse<AuthResponse>>(
      future: client.auth(),
      builder: (context, response) {
        if (response.connectionState == ConnectionState.done) {
          if (response.hasError) {
            return Scaffold(body: LoginScreen());
          } else {
            storage.write(key: MyApp.TOKEN, value: response.data.data.token);
            dio.options.headers[MyApp.AUTH] = response.data.data.token;
            return HomeScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
