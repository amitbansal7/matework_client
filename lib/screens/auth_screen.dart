import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/widgets/auth_wdiget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class AuthScreen extends StatelessWidget {
  static final routeName = "/";
  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<FlutterSecureStorage>(context);
    return FutureBuilder<String>(
      future: storage.read(key: MyApp.TOKEN),
      builder: (context, token) {
        if (token.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ProxyProvider<Dio, AuthRestClient>(
                update: (_, dio, __) {
                  return AuthRestClient(dio);
                },
              )
            ],
            child: Scaffold(body: AuthWidget()),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
