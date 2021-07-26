import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:Matework/screens/account_screen.dart';
import 'package:Matework/screens/auth_screen.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/screens/edit_profile_screen.dart';
import 'package:Matework/screens/user_chat_screen_wrapper.dart';
import 'package:Matework/screens/user_profile_wrapper.dart';
import 'package:Matework/utils.dart';
import 'package:Matework/viewmodels/auth_viewmodel.dart';
import 'package:Matework/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'database.dart';
import 'network/auth_rest_client.dart';
import 'network/chats_rest_client.dart';
import 'services/user_data_channel_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Future<String?> authToken =
      FlutterSecureStorage().read(key: AUTHORIZATION);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => FutureBuilder<String?>(
        future: authToken,
        builder: (context, token) {
          if (token.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                Provider.value(value: AppDatabase()),
                Provider.value(value: FlutterSecureStorage()),
                Provider<Dio>(
                  create: (context) {
                    final dio = Dio();
                    if (token.data != null) {
                      dio.options.headers[AUTHORIZATION] = token.data;
                    }
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
                ProxyProvider<Dio, AuthRestClient>(
                  update: (_, dio, __) {
                    return AuthRestClient(dio);
                  },
                ),
                ChangeNotifierProxyProvider<AuthRestClient, AuthViewModel>(
                  create: (_) => AuthViewModel(),
                  update: (_, authRestClient, viewModel) {
                    viewModel!.setAuthRestClient = authRestClient;
                    return viewModel;
                  },
                ),
                Provider.value(value: Logger()),
              ],
              child: MaterialApp(
                title: 'Matework',
                theme: ThemeData(
                    scaffoldBackgroundColor: Color.fromRGBO(255, 250, 245, 1)),
                onGenerateRoute: (settings) {
                  Map<String, dynamic> arguments = (settings.arguments ??
                      Map<String, dynamic>()) as Map<String, dynamic>;

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
                  } else if (settings.name == EditProfileScreen.routeName) {
                    return SlideLeftRoute(page: EditProfileScreen());
                  } else {
                    return SlideLeftRoute(page: AuthScreen());
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
