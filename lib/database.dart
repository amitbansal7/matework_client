import 'dart:async';
import 'dart:io';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:moor/moor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:Matework/models/invite.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:moor/ffi.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;
import 'package:path/path.dart' as p;

import 'models/chat_message.dart';

part 'database.g.dart';

@UseMoor(tables: [Invites, ChatUsers, ChatMessages])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(LazyDatabase(() async {
          final dbFolder = await getDatabasesPath();
          final file = File(p.join(dbFolder, 'db.sqlite'));
          return VmDatabase(file);
        }));
  int get schemaVersion => 1;

  Stream<List<Invite>> watchAllInvites() => (select(invites)
        ..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
        ]))
      .watch();

  Future<List<Invite>> getAllInvites() => select(invites).get();

  Future<void> insertInvite(Invite entry) {
    return into(invites).insertOnConflictUpdate(entry);
  }

  Future<int> deleteInviteById(int inviteId) async {
    return (delete(invites)..where((tbl) => tbl.id.equals(inviteId))).go();
  }

  Future<int> markInviteAsSeen(int inviteId) async {
    return (update(invites)..where((t) => t.id.equals(inviteId))).write(
      InvitesCompanion(
        seen: Value(true),
      ),
    );
  }

  Future<void> deleteAllAndinsertInvites(List<Invite> allInvites) async {
    return transaction(() async {
      await delete(invites).go();
      await batch((batch) {
        batch.insertAllOnConflictUpdate(invites, allInvites);
      });
    });
  }

  Stream<List<ChatUser>> watchAllChatUsers() => (select(chatUsers)
        ..orderBy([
          (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)
        ]))
      .watch();

  Future<void> deleteAllAndinsertChatUsers(List<ChatUser> allChatUsers) async {
    return transaction(() async {
      await delete(chatUsers).go();
      await batch((batch) {
        batch.insertAllOnConflictUpdate(chatUsers, allChatUsers);
      });
    });
  }

  Stream<List<ChatMessage>> watchAllMessages() => (select(chatMessages)
        ..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)
        ]))
      .watch();

  Future<void> insertChatMessage(ChatMessagesCompanion chatMessage) {
    return into(chatMessages).insert(chatMessage);
  }

  Stream<List<ChatMessage>> watchAllMessagesById(int inviteId) {
    return (select(chatMessages)
          ..where((tbl) => tbl.inviteId.equals(inviteId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future<ChatMessage> getLastChatMessageByInviteId(int inviteId) {
    return (select(chatMessages)
          ..where((tbl) => tbl.inviteId.equals(inviteId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Stream<List<ChatMessage>> watchAllUnSentMessages() {
    return (select(chatMessages)..where((tbl) => tbl.sent.equals(false)))
        .watch();
  }

  Future<void> markChatMessageAsSend(int id, int serverId) {
    return (update(chatMessages)..where((t) => t.id.equals(id))).write(
      ChatMessagesCompanion(
        sent: Value(true),
        serverId: Value(serverId),
      ),
    );
  }

  Future<void> markAllChatMessageSeenByInviteId(int inviteId) {
    return (update(chatMessages)..where((tbl) => tbl.inviteId.equals(inviteId)))
        .write(ChatMessagesCompanion(seen: Value(true)));
  }

  Stream<int> countUnseenChatMessageByInviteId(int inviteId) {
    final expr = countAll(
        filter: chatMessages.inviteId.equals(inviteId) &
            chatMessages.seen.equals(false));

    return (selectOnly(chatMessages)..addColumns([expr]))
        .map((row) => row.read(expr))
        .watchSingle();
  }

  Future<ChatUser> findChatUserById(int id) {
    return (select(chatUsers)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> setChatUserUpdatedAtByInviteId(int inviteId, int updatedAt) {
    return (update(chatUsers)..where((t) => t.inviteId.equals(inviteId))).write(
      ChatUsersCompanion(updatedAt: Value(updatedAt)),
    );
  }
}
