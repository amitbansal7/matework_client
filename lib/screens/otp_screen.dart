// @dart=2.9

import 'dart:convert';

import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../utils.dart';

class OtpScreenWrapper extends StatelessWidget {
  static final routeName = "enter_otp";
  final String phone;

  OtpScreenWrapper({this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OtpScreen(phone: phone));
  }
}

class OtpScreen extends StatefulWidget {
  final String phone;

  OtpScreen({this.phone});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = "";
  @override
  Widget build(BuildContext context) {
    // final params =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;

    final storage = FlutterSecureStorage();
    final dio = Provider.of<Dio>(context);
    final restClient = AuthRestClient(dio);
    final logger = Provider.of<Logger>(context, listen: false);

    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify Mobile Number",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text("We have sent an OTP on ${widget.phone}",
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 40),
              Text("Please check your message", style: TextStyle(fontSize: 20)),
              SizedBox(height: 40),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder:
                      FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                codeLength: 4,
                currentCode: _otp,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code.length == 4) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  _otp = code;
                },
              ),
              SizedBox(height: 40),
              Container(
                width: 170,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black,
                ),
                child: TextButton(
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    restClient.verify(widget.phone, _otp).then((res) {
                      storage.write(key: AUTHORIZATION, value: res.data.token);
                      print(res.data.token);
                      dio.options.headers[AUTHORIZATION] = res.data.token;
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    }).catchError((Object obj) {
                      switch (obj.runtimeType) {
                        case DioError:
                          final res = (obj as DioError).response;
                          ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
                                  message: res.data["message"], error: true)
                              .getSnackbar());

                          logger.e(
                              "Wrong creds ${res.statusCode} -> ${res.statusMessage}");
                          break;
                        default:
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
