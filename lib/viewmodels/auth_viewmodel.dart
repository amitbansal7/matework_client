import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/auth_response.dart';
import 'package:tuple/tuple.dart';
import 'package:Matework/database.dart';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/network/auth_rest_client.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../utils.dart';

class AuthViewModel extends ChangeNotifier {
  late AuthRestClient authRestClient;

  set setAuthRestClient(AuthRestClient authRestClient) {
    this.authRestClient = authRestClient;
  }

  Future<Tuple2<bool, String>> sendOtp(String phoneNumber) async {
    try {
      final response = await authRestClient.sendOtp(phoneNumber);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      print(e.toString());
      return new Tuple2(
          false,
          (e.response?.data != null
              ? e.response?.data["message"]
              : SOMETHING_WRONG));
    }
  }

  Future<Tuple2<bool, ApiResponse<AuthResponse>>> verifyOtp(
      String phoneNumber, String otp) async {
    try {
      final response = await authRestClient.verify(phoneNumber, otp);
      return new Tuple2(true, response);
    } on DioError catch (e) {
      return new Tuple2(
          false,
          (e.response?.data != null
              ? e.response?.data["message"]
              : SOMETHING_WRONG));
    }
  }
}
