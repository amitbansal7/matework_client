import 'dart:convert';

import 'package:Matework/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moor/moor.dart';
import 'package:websocket_manager/websocket_manager.dart';

import '../utils.dart';

class UserDataChannelManager {
  final AppDatabase db;
  late WebsocketManager socket;
  final FlutterSecureStorage secureStorage;
  late int myId;

  UserDataChannelManager({required this.db, required this.secureStorage}) {
    _init();
    _setupConnection();
    _sendUnSendMessages();
  }

  void _init() async {
    myId = int.parse(await secureStorage.read(key: My_ID));
    print("MyIDINUserDataChannelManager -> ${myId}");
  }

  void sendMessage(ChatMessage message) {
    final data = jsonEncode({
      "command": 'message',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
      "data": jsonEncode({
        "action": "send_message",
        "message": message.message,
        "invite_id": message.inviteId,
        "message_client_id": message.id,
      }),
    });

    socket.send(data);
  }

  void _setupConnection() async {
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    socket = WebsocketManager(BASE_SOCKET_URL, {
      AUTHORIZATION: token,
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

    socket.onMessage((dynamic message) {
      final Map<String, dynamic> data = json.decode(message);
      if (data["type"] == "ping") {
        return;
      }

      if (data.containsKey("identifier") &&
          json.decode(data["identifier"])["channel"] == "UserDataChannel" &&
          data.containsKey("message") &&
          data["message"]["type"] == "Message") {
        print(data);

        final messagePacket = data["message"];

        db.setChatUserUpdatedAtByInviteId(messagePacket["invite_id"],
            DateTime.now().millisecondsSinceEpoch ~/ 1000);

        if (messagePacket["sender_id"] == myId) {
          db.markChatMessageAsSend(
              messagePacket["message_client_id"], messagePacket["id"]);
        } else {
          print("Inserting message");
          db.insertChatMessage(
            ChatMessagesCompanion(
              serverId: Value(messagePacket["id"]),
              inviteId: Value(messagePacket["invite_id"]),
              senderId: Value(messagePacket["sender_id"]),
              message: Value(messagePacket["message"]),
              sent: Value(true),
              seen: Value(true),
              createdAt: Value(messagePacket["created_at"]),
            ),
          );
        }
        if (myId != messagePacket["sender_id"]) {
          _sendMessageConfirmation(messagePacket["id"]);
        }
      }
    });
  }

  void _sendUnSendMessages() {
    print("_sendUnSendMessages 1");
    db.watchAllUnSentMessages().listen((messages) {
      messages.forEach((message) {
        print("Sending unsend message ");
        sendMessage(message);
      });
    });
  }

  void _sendMessageConfirmation(int messageId) {
    final data = jsonEncode({
      "command": 'message',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
      "data": jsonEncode({
        "action": "message_received",
        "message_id": messageId,
      }),
    });

    socket.send(data);
  }
}
