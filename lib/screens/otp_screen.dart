import 'dart:convert';

import 'package:Matework/main.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/screens/home_screen.dart';
import 'package:Matework/viewmodels/auth_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils.dart';

class OtpScreenWrapper extends StatelessWidget {
  static final routeName = "enter_otp";
  final String phone;

  OtpScreenWrapper({required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OtpScreen(phone: phone));
  }
}

class OtpScreen extends StatefulWidget {
  final String phone;

  OtpScreen({required this.phone});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = "";
  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    final dio = Provider.of<Dio>(context);
    final logger = Provider.of<Logger>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify Mobile Number",
                style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 35.h),
              Text("We have sent an OTP on ${widget.phone}",
                  style: TextStyle(fontSize: 15.sp)),
              SizedBox(height: 35.h),
              Text("Please check your message",
                  style: TextStyle(fontSize: 15.sp)),
              SizedBox(height: 35.h),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
                  colorBuilder:
                      FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                codeLength: 4,
                currentCode: _otp,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code?.length == 4) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  _otp = code!;
                },
              ),
              SizedBox(height: 35.h),
              Container(
                width: 140.w,
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(40.r),
                  color: Colors.black,
                ),
                child: TextButton(
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  onPressed: () async {
                    final response =
                        await authViewModel.verifyOtp(widget.phone, _otp);
                    if (response.item1) {
                      storage.write(
                          key: AUTHORIZATION,
                          value: response.item2?.data.token);
                      dio.options.headers[AUTHORIZATION] =
                          response.item2?.data.token;
                      storage.write(
                          key: My_ID,
                          value: response.item2?.data.user.id.toString());
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          MySnackBar(message: SOMETHING_WRONG, error: true)
                              .getSnackbar());

                      logger.e("Wrong creds ${response.item2}");
                    }
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
