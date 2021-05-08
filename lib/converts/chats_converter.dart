import 'package:Matework/network/response/chat_user_response.dart';

import '../database.dart';

ChatUser chatUserResponseToChatUser(ChatUserResponse e) {
  return ChatUser(
    id: e.id!,
    updatedAt: e.updatedAt!,
    firstName: e.firstName,
    lastName: e.lastName,
    avatar: e.avatar,
    inviteId: e.inviteId!,
  );
}
