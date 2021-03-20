// @dart=2.9

import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/screens/auth_screen.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/screens/user_chat_screen.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import './network/response/auth_response.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final AUTH = "Authorization";
  static final TOKEN = "token";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: FlutterSecureStorage().read(key: MyApp.TOKEN),
      builder: (context, token) {
        if (token.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<Dio>(
                create: (context) {
                  final dio = Dio();
                  dio.options.headers[MyApp.AUTH] = token.data;
                  return dio;
                },
              ),
              Provider.value(value: Logger()),
              Provider.value(value: FlutterSecureStorage()),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              // routes: {
              //   LoginScreen.routeName: (context) => LoginScreen(),
              //   HomeScreen.routeName: (context) => HomeScreen(),
              //   OtpScreenWrapper.routeName: (context) => OtpScreenWrapper(),
              //   UserProfileScreen.routeName: (context) => UserProfileScreen(),
              //   // DetailScreen.routeName: (context) => DetailScreen(),
              // },
              onGenerateRoute: (settings) {
                final arguments = settings.arguments as Map<String, dynamic>;
                if (settings.name == LoginScreen.routeName) {
                  return SlideLeftRoute(page: LoginScreen());
                } else if (settings.name == HomeScreen.routeName) {
                  return SlideLeftRoute(page: HomeScreen());
                } else if (settings.name == OtpScreenWrapper.routeName) {
                  return SlideLeftRoute(
                      page: OtpScreenWrapper(phone: arguments["phone"]));
                } else if (settings.name == UserProfileScreen.routeName) {
                  return SlideLeftRoute(page: UserProfileScreen());
                } else if (settings.name == UserChatScreen.routeName) {
                  return SlideLeftRoute(
                      page: UserChatScreen(userId: arguments["userId"]));
                } else {
                  return MaterialPageRoute(builder: (_) => AuthScreen());
                }
              },
              home: AuthScreen(),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
