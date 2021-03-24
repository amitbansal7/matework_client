// @dart=2.9

import 'dart:async';
import 'package:Matework/models/chat_user.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:Matework/models/invite.dart';
import 'package:Matework/repositories/invites_repository.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Invite, ChatUser])
abstract class AppDatabase extends FloorDatabase {
  InviteRepository get inviteRepository;
  ChatsRepository get chatsRepository;
}
