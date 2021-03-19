// @dart=2.9

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:Matework/models/invite.dart';
import 'package:Matework/repositories/invites_repository.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Invite])
abstract class AppDatabase extends FloorDatabase {
  InviteRepository get inviteRepository;
}
