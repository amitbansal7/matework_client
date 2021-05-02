import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/screens/account_screen.dart';
import 'package:Matework/screens/auth_screen.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_wrapper.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => FutureBuilder<String>(
        future: FlutterSecureStorage().read(key: AUTHORIZATION),
        builder: (context, token) {
          if (token.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                Provider.value(value: AppDatabase()),
                Provider.value(value: FlutterSecureStorage()),
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
                ProxyProvider<Dio, UserProfilesRestClient>(
                  update: (_, dio, __) {
                    return UserProfilesRestClient(dio);
                  },
                ),
                ProxyProvider2<AppDatabase, FlutterSecureStorage,
                    UserDataChannelManager>(
                  update: (_, db, storage, __) {
                    return UserDataChannelManager(
                        db: db, secureStorage: storage);
                  },
                ),
                Provider.value(value: Logger()),
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
                  } else if (settings.name ==
                      UserProfileScreenWrapper.routeName) {
                    return SlideLeftRoute(
                        page: UserProfileScreenWrapper(
                            userId: arguments["userId"]));
                  } else if (settings.name == AccountScreen.routeName) {
                    return SlideLeftRoute(page: AccountScreen());
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
      ),
    );
  }
}
