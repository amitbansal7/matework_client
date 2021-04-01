import 'dart:convert';

import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/utils.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _countryCode = "+91";
  TextEditingController phoneNumberController = TextEditingController();

  String _finalPhone() {
    return _countryCode + phoneNumberController.value.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.only(bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 150,
            alignment: Alignment.topRight,
          ),
          SizedBox(height: 10),
          Text(
            "Matework",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 60),
          _phoneNumberInput(),
          SizedBox(height: 60),
          _sendOtpButton(),
        ],
      ),
    );
  }

  Widget _phoneNumberInput() {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountryCodePicker(
            onChanged: (code) {
              _countryCode = code.dialCode.toString();
            },
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'IN',
            favorite: ['+91', 'IN'],
            // optional. Shows only country name and flag
            showCountryOnly: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Phone Number",
              ),
              controller: phoneNumberController,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendOtpButton() {
    final authClient = Provider.of<AuthRestClient>(context, listen: false);
    final logger = Provider.of<Logger>(context, listen: false);
    return Container(
      width: 170,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(40),
        color: Colors.black,
      ),
      child: TextButton(
        child: Text(
          "SEND OTP >",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          final ctx = context;
          authClient.sendOtp(_finalPhone()).then((it) {
            // Scaffold.of(ctx).showSnackBar(
            //     MySnackBar(message: it.message, error: false).getSnackbar());
            Navigator.of(context).pushNamed(OtpScreenWrapper.routeName,
                arguments: {"phone": _finalPhone()});
          }).catchError((Object obj) {
            // non-200 error goes here.
            switch (obj.runtimeType) {
              case DioError:
                final res = (obj as DioError).response;
                ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
                  message: SOMETHING_WRONG,
                  error: true,
                ).getSnackbar());
                logger.e(
                    "Got error : ${res!.statusCode} -> ${res.statusMessage}");
                break;
              default:
            }
          });
        },
      ),
    );
  }
}
