import 'package:Matework/models/invite.dart';
import 'package:floor/floor.dart';

@dao
abstract class InviteRepository {
  @Query('SELECT * FROM Invite ORDER BY createdAt DESC')
  Future<List<Invite>> findAllInvites();

  // @Query(
  //     'INSERT INTO Invite (id, message, createdAt, userId, userFirstName, userLastName, userAvatar) VALUES (:id, :message, :createdAt, :userId, :userFirstName, :userLastName, :userAvatar)')
  // Future<void> insertInvite(
  //     int? id,
  //     String? message,
  //     int? createdAt,
  //     int? userId,
  //     String? userFirstNamee,
  //     String? userLastName,
  //     String? userAvatar);

  @insert
  Future<void> insertInvite(Invite invite);

  @Query("DELETE FROM Invite")
  Future<void> deleteAll();

  @Query("DELETE FROM Invite where id = :id")
  Future<void> deleteById(int? id);
}
