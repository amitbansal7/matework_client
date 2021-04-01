// import 'package:Matework/models/chat_user.dart';
// import 'package:Matework/models/invite.dart';
// import 'package:floor/floor.dart';

// @dao
// abstract class ChatsRepository {
//   @Query('SELECT * FROM ChatUser ORDER BY updatedAt DESC')
//   Future<List<ChatUser>> findChatUsers();

//   // // @Query(
//   // //     'INSERT INTO Invite (id, message, createdAt, userId, userFirstName, userLastName, userAvatar) VALUES (:id, :message, :createdAt, :userId, :userFirstName, :userLastName, :userAvatar)')
//   // // Future<void> insertInvite(
//   // //     int? id,
//   // //     String? message,
//   // //     int? createdAt,
//   // //     int? userId,
//   // //     String? userFirstNamee,
//   // //     String? userLastName,
//   // //     String? userAvatar);

//   @insert
//   Future<void> insertChatUser(ChatUser chatUser);

//   @Query("DELETE FROM ChatUser")
//   Future<void> deleteAllChatUsers();

//   // @Query("DELETE FROM Invite where id = :id")
//   // Future<void> deleteById(int? id);
// }
