import 'dart:io';

const BASE_SOCKET_URL = "ws://192.168.1.7:3000/cable";
const AUTHORIZATION = "Authorization";
const String BASE_API_URL = "http://192.168.1.7:3000/api";
const String SOMETHING_WRONG = "Something Went Wrong. Try again after sometime";

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
