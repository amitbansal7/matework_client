import 'dart:convert';

import 'package:Matework/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:websocket_manager/websocket_manager.dart';

import '../utils.dart';

class UserDataChannelManager {
  final AppDatabase db;
  late WebsocketManager socket;
  UserDataChannelManager({required this.db}) {
    _setupConnection();
  }

  void sendMessage(int inviteId, String message) {
    final data = jsonEncode({
      "command": 'message',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
      "data": jsonEncode({
        "action": "send_message",
        "message": message,
        "invite_id": inviteId,
      }),
    });

    socket.send(data);
  }

  void _setupConnection() async {
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    socket = WebsocketManager(BASE_SOCKET_URL, {
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
        print(data["message"]["message"]);

        final messagePacket = data["message"];

        db.getChatUserUpdatedAtByInviteId(messagePacket["invite_id"],
            DateTime.now().millisecondsSinceEpoch ~/ 1000);

        db.insertChatMessage(
          ChatMessage(
            id: messagePacket["id"],
            inviteId: messagePacket["invite_id"],
            senderId: messagePacket["sender_id"],
            message: messagePacket["message"],
            sent: true,
            createdAt: messagePacket["created_at"],
          ),
        );
      }
    });
  }
}
