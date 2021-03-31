import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:websocket_manager/websocket_manager.dart';

import '../utils.dart';

class UserDataChannelManager {
  UserDataChannelManager() {
    _setupConnection();
  }
  void _setupConnection() async {
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    final socket = WebsocketManager(BASE_SOCKET_URL, {
      AUTHORIZATION: token,
    });
    socket.connect();
    final data = jsonEncode({
      "command": 'subscribe',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
    });

    socket.send(data);
    print(data);
    socket.onMessage((dynamic message) {
      final Map<String, dynamic> data = json.decode(message);
      if (data["type"] == "ping") {
        return;
      }
      print(message);
      if (data.containsKey("identifier") &&
          json.decode(data["identifier"])["channel"] == "UserDataChannel" &&
          data.containsKey("message") &&
          data["message"]["type"] == "Message") {
        // setState(() {
        //   messages.add(data["message"]["message"]);
        // });
      }
    });
  }
}
