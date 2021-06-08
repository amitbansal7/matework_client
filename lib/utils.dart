import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

const BASE_DOMAIN = "192.168.1.4";
const BASE_SOCKET_URL = "ws://$BASE_DOMAIN:3334/cable";
const AUTHORIZATION = "Authorization";
const String BASE_API_URL = "http://$BASE_DOMAIN:3000/api";
const String SOMETHING_WRONG = "Something Went Wrong. Try again after sometime";
const My_ID = "my_id";

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

Future<bool> deleteAllData(Dio dio) async {
  final flutterStorage = FlutterSecureStorage();
  dio.options.headers.clear();
  await flutterStorage.write(key: AUTHORIZATION, value: null);
  await flutterStorage.write(key: My_ID, value: null);
  return true;
}
