import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/screens/auth_screen.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/screens/login_screen.dart';
import 'package:Matework/screens/otp_screen.dart';
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
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: {
                LoginScreen.routeName: (context) => LoginScreen(),
                HomeScreen.routeName: (context) => HomeScreen(),
                OtpScreen.routeName: (context) => OtpScreen(),
                // DetailScreen.routeName: (context) => DetailScreen(),
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

// class DetailScreen extends StatelessWidget {
//   static final routeName = "details";
//   @override
//   Widget build(BuildContext context) {
//     final dio = Provider.of<Dio>(context, listen: false);
//     return Scaffold(
//       body: Center(
//         child: Text(dio.options.headers[MyApp.AUTH]),
//       ),
//     );
//   }
// }
