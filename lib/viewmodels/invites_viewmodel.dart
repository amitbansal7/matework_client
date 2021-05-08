// @dart=2.9

import 'dart:collection';

import 'package:Matework/converts/invites_converter.dart';
import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tuple/tuple.dart';

import '../database.dart';

class InvitesViewModel extends ChangeNotifier {
  static const INVITES_UPDATE_AT = "InvitesFromApi";
  InvitesRestClient invitesRestClient;
  AppDatabase db;

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Stream<List<Invite>> _invites;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
    _invites = db.watchAllInvites();
  }

  Stream<List<Invite>> get getInvites => _invites;

  set setInvitesRestClient(InvitesRestClient invitesRestClient) {
    this.invitesRestClient = invitesRestClient;
  }

  Future<Tuple2<bool, String>> acceptInvite(int inviteId) async {
    try {
      final response = await invitesRestClient?.acceptInvite(inviteId);
      db.deleteInviteById(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      return new Tuple2(
          false,
          (e.response?.data != null
              ? e.response.data["message"]
              : SOMETHING_WRONG));
    }
  }

  Future<Tuple2<bool, String>> deleteInvite(int inviteId) async {
    try {
      final response = await invitesRestClient.deleteInvite(inviteId);
      db.deleteInviteById(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      return new Tuple2(
          false,
          (e.response?.data != null
              ? e.response.data["message"]
              : SOMETHING_WRONG));
    }
  }

  void markAsSeen(int inviteId) async {
    db.markInviteAsSeen(inviteId);
  }

  void getInvitesFromApi() async {
    final currentTs = DateTime.now().millisecondsSinceEpoch;
    final tsString = (await secureStorage.read(key: INVITES_UPDATE_AT)) ?? "0";
    final updateAt = int.parse(tsString);
    if (updateAt != 0 && updateAt > currentTs) return;
    try {
      final apiResponse = await invitesRestClient?.getAllInvites();
      final dbInvites = await db.getAllInvites();
      final allSeen = dbInvites.expand((e) => e.seen ? [e.id] : []).toSet();

      final inviteResponse = apiResponse?.data?.invites;
      final invites = inviteResponse?.map((e) {
        return inviteFromInvitesResponse(e, allSeen.contains(e.id));
      });

      db.deleteAllAndinsertInvites(invites.toList());
      final nextUpdateAt =
          DateTime.now().add(Duration(minutes: 15)).millisecondsSinceEpoch;
      secureStorage.write(
          key: INVITES_UPDATE_AT, value: nextUpdateAt.toString());
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
