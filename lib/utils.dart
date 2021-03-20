import 'dart:io';

const String BASE_API_URL = "http://192.168.1.9:3000/api";
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
