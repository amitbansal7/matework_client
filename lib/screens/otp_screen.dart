import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class OtpScreen extends StatelessWidget {
  static final routeName = "enter_otp";
  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    final dio = Provider.of<Dio>(context);
    final restClient = AuthRestClient(dio);
    final logger = Provider.of<Logger>(context, listen: false);
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("ENTER OTP"),
          onPressed: () {
            restClient.verify("+919711185625", "asdf").then((res) {
              storage.write(key: MyApp.TOKEN, value: res.data.token);
              dio.options.headers[MyApp.AUTH] = res.data.token;
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/");
            }).catchError((Object obj) {
              switch (obj.runtimeType) {
                case DioError:
                  final res = (obj as DioError).response;
                  logger.e(
                      "Wrong creds ${res.statusCode} -> ${res.statusMessage}");
                  break;
                default:
              }
            });
          },
        ),
      ),
    );
  }
}
