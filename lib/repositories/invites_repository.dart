import 'package:Matework/models/invite.dart';
import 'package:floor/floor.dart';

@dao
abstract class InviteRepository {
  @Query('SELECT * FROM Invite')
  Future<List<Invite>> findAllInvites();

  @Query(
      'INSERT OR REPLACE INTO Invite (id, message, createdAt, userId, userFirstName, userLastName) VALUES (:id, :message, :createdAt, :userId, :userFirstName, :userLastName)')
  Future<void> insertInvite(int? id, String? message, int? createdAt,
      int? userId, String? userFirstNamee, String? userLastName);

  @Query("DELETE FROM Invite")
  Future<void> deleteAll();

  @Query("DELETE FROM Invite where id = :id")
  Future<void> deleteById(int? id);
}
