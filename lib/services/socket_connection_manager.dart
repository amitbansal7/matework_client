import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:websocket_manager/websocket_manager.dart';

import '../utils.dart';

class SocketConnectionManager {
  void setupConnection() async {
    print("setupConnection");
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    final socket = WebsocketManager(BASE_SOCKET_URL, {
      AUTHORIZATION: token!,
    });
    socket.close();
    socket.connect();

    final data = jsonEncode({
      "command": 'subscribe',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
    });

    socket.send(data);
  }
}
