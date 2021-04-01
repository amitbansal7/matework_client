// @dart=2.9

import 'dart:collection';

import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

import '../database.dart';

class InvitesViewModel extends ChangeNotifier {
  InvitesRestClient invitesRestClient;
  AppDatabase db;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
  }

  set setInvitesRestClient(InvitesRestClient invitesRestClient) {
    this.invitesRestClient = invitesRestClient;
  }

  Future<Tuple2<bool, String>> acceptInvite(int inviteId) async {
    try {
      final response = await invitesRestClient?.acceptInvite(inviteId);
      db.deleteInviteById(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      return new Tuple2(false, e.response?.data["message"] ?? SOMETHING_WRONG);
    }
  }

  Future<Tuple2<bool, String>> deleteInvite(int inviteId) async {
    try {
      final response = await invitesRestClient.deleteInvite(inviteId);
      db.deleteInviteById(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      print(e.message);
      return new Tuple2(false, e.response?.data["message"] ?? SOMETHING_WRONG);
    }
  }

  void markAsSeen(int inviteId) async {
    db.markInviteAsSeen(inviteId);
  }

  void getInvitesFromApi() async {
    try {
      final apiResponse = await invitesRestClient?.getAllInvites();
      final dbInvites = await db.getAllInvites();
      final allSeen = dbInvites.expand((e) => e.seen ? [e.id] : []).toSet();

      final inviteResponse = apiResponse?.data?.invites;
      final invites = inviteResponse?.map((e) {
        return Invite(
          id: e.id,
          message: e.message,
          createdAt: e.createdAt,
          seen: allSeen.contains(e.id),
          userAvatar: e.user?.avatar,
          userFirstName: e.user?.firstName,
          userLastName: e.user?.lastName,
          userId: e.user?.id,
        );
      });
      print(invites);
      db.deleteAllAndinsertInvites(invites.toList());
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
