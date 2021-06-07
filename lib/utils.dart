import 'dart:io';

const BASE_DOMAIN = "192.168.1.8";
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
