import 'dart:convert';

import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/screens/otp_screen.dart';
import 'package:Matework/utils.dart';
import 'package:Matework/viewmodels/auth_viewmodel.dart';
import 'package:Matework/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final authRestClient = Provider.of<AuthRestClient>(context);

    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.only(bottom: 70.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 100.w,
            alignment: Alignment.topRight,
          ),
          SizedBox(height: 7.h),
          Text(
            "Matework",
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 40.h),
          _phoneNumberInput(),
          SizedBox(height: 40.h),
          _sendOtpButton(),
        ],
      ),
    );
  }

  Widget _phoneNumberInput() {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(10.r),
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
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final logger = Provider.of<Logger>(context, listen: false);
    return Container(
      width: 130.w,
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.black,
      ),
      child: TextButton(
        child: Text(
          "SEND OTP >",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
        onPressed: () async {
          final response = await authViewModel.sendOtp(_finalPhone());
          if (response.item1) {
            Navigator.of(context).pushNamed(OtpScreenWrapper.routeName,
                arguments: {"phone": _finalPhone()});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
              message: SOMETHING_WRONG,
              error: true,
            ).getSnackbar());
            logger.e("Got error : ${response.item2}");
          }
        },
      ),
    );
  }
}
