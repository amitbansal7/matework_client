import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/screens/auth_screen.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_screen.dart';
import 'package:Matework/utils.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import './network/response/auth_response.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'database.dart';
import 'network/chats_rest_client.dart';
import 'network/invites_rest_client.dart';
import 'services/user_data_channel_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: FlutterSecureStorage().read(key: AUTHORIZATION),
      builder: (context, token) {
        if (token.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<AppDatabase>(create: (_) {
                return AppDatabase();
              }),
              Provider<Dio>(
                create: (context) {
                  final dio = Dio();
                  dio.options.headers[AUTHORIZATION] = token.data;
                  return dio;
                },
              ),
              ProxyProvider<Dio, ChatsRestClient>(
                update: (_, dio, __) {
                  return ChatsRestClient(dio);
                },
              ),
              ProxyProvider<AppDatabase, UserDataChannelManager>(
                update: (_, db, __) {
                  return UserDataChannelManager(db: db);
                },
              ),
              Provider.value(value: Logger()),
              Provider.value(value: FlutterSecureStorage()),
            ],
            child: MaterialApp(
              title: 'Matework',
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
                } else if (settings.name == UserChatScreenWrapper.routeName) {
                  return SlideLeftRoute(
                      page: UserChatScreenWrapper(
                          chatUserId: arguments["chatUserId"]));
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
