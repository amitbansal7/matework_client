import 'dart:io';

import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/utils.dart';
import 'package:Matework/widgets/my_snackbar.dart';
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
    final dio = Provider.of<Dio>(context, listen: false);

    if (dio.options.headers[AUTHORIZATION] == null) {
      return LoginScreen();
    }
    return FutureBuilder<bool>(
      future: checkInternet(),
      builder: (context, isInternet) {
        if (isInternet.connectionState == ConnectionState.done) {
          if (isInternet.data == true) {
            return FutureBuilder<ApiResponse<AuthResponse>>(
              future: client.auth(),
              builder: (context, authResponse) {
                if (authResponse.connectionState == ConnectionState.done) {
                  if (authResponse.hasError) {
                    final error = authResponse.error as DioError;
                    if (error.message.contains("SocketException")) {
                      return HomeScreen();
                    } else {
                      return LoginScreen();
                    }
                  } else {
                    return HomeScreen();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return HomeScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
