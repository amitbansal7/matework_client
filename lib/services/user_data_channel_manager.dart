import 'dart:convert';

import 'package:Matework/converts/chats_converter.dart';
import 'package:Matework/converts/invites_converter.dart';
import 'package:Matework/database.dart';
import 'package:Matework/network/response/chat_user_response.dart';
import 'package:Matework/network/response/invite_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moor/moor.dart';
import 'package:web_socket_channel/io.dart';

import '../utils.dart';

class UserDataChannelManager {
  final AppDatabase db;
  late IOWebSocketChannel socket;
  final FlutterSecureStorage secureStorage;
  late int myId;

  UserDataChannelManager({required this.db, required this.secureStorage}) {
    _init();
    _setupConnection();
    _sendUnSendMessages();
  }

  void _init() async {
    final idStr = await secureStorage.read(key: My_ID);
    myId = int.parse(idStr!);
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

    _sendData(data);
  }

  void _sendData(String data) {
    _ensureConnection();
    socket.sink.add(data);
  }

  void _ensureConnection() {
    try {
      socket.sink.add("d");
    } catch (e) {
      _setupConnection();
    }
  }

  void _setupConnection() async {
    final token = await FlutterSecureStorage().read(key: AUTHORIZATION);
    final urlWithToken = BASE_SOCKET_URL + "?$AUTHORIZATION=$token";
    socket = IOWebSocketChannel.connect(Uri.parse(urlWithToken));

    final data = jsonEncode({
      "command": 'subscribe',
      "identifier": jsonEncode({
        "channel": 'UserDataChannel',
      }),
    });

    socket.sink.add(data);

    _registerOnMessage();
    // socket.onClose((data) => print("Socket session Closed $data"));
  }

  void _registerOnMessage() {
    socket.stream.listen((dynamic message) {
      final Map<String, dynamic> data = json.decode(message);
      print(message);
      if (data["type"] == "ping") {
        return;
      }
      if (!data.containsKey("identifier") ||
          json.decode(data["identifier"])["channel"] != "UserDataChannel" ||
          !data.containsKey("message")) {
        return;
      }

      final type = data["message"]["type"];
      final packet = data["message"]["packet"];
      if (type == "message_created") {
        _handleChatMessage(packet);
      } else if (type == "invite_created") {
        _handeInviteCreated(packet);
      } else if (type == "invite_accepted") {
        _handeInviteAccepted(packet);
      }
    });
  }

  void _handeInviteCreated(Map<String, dynamic> packet) {
    final inviteResponse = InviteResponse.fromJson(packet);
    final invite = inviteFromInvitesResponse(inviteResponse, false);
    db.insertInvite(invite);
  }

  void _handeInviteAccepted(Map<String, dynamic> packet) {
    final chatUserResponse = ChatUserResponse.fromJson(packet);
    final chatUser = chatUserResponseToChatUser(chatUserResponse);
    db.insertChatUser(chatUser);
    db.deleteInviteById(chatUser.inviteId);
  }

  void _handleChatMessage(Map<String, dynamic> packet) {
    db.setChatUserUpdatedAtByInviteId(
        packet["invite_id"], DateTime.now().millisecondsSinceEpoch ~/ 1000);

    if (packet["sender_id"] == myId) {
      db.markChatMessageAsSend(packet["message_client_id"], packet["id"]);
    } else {
      db.insertChatMessage(
        ChatMessagesCompanion(
          serverId: Value(packet["id"]),
          inviteId: Value(packet["invite_id"]),
          senderId: Value(packet["sender_id"]),
          message: Value(packet["message"]),
          sent: Value(true),
          seen: Value(false),
          createdAt: Value(packet["created_at"]),
        ),
      );
    }
    if (myId != packet["sender_id"]) {
      _sendMessageConfirmation(packet["id"]);
    }
  }

  void _sendUnSendMessages() {
    db.watchAllUnSentMessages().listen((messages) {
      messages.forEach((message) {
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
    _sendData(data);
  }
}
