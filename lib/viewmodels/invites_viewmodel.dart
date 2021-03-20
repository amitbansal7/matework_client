import 'dart:collection';

import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

class InvitesViewModel extends ChangeNotifier {
  InviteRepository? inviteRepository;
  InvitesRestClient? invitesRestClient;
  List<Invite> _invites = [];

  bool _checkedFromApi = false;

  bool get checkedFromApi => _checkedFromApi;

  List<Invite> get invites => _invites;

  set setInviteRepository(InviteRepository repository) {
    this.inviteRepository = repository;
  }

  set setInvitesRestClient(InvitesRestClient invitesRestClient) {
    this.invitesRestClient = invitesRestClient;
  }

  void getAllInvites() async {
    _checkedFromApi = false;
    _invites = await inviteRepository!.findAllInvites();
    getInvitesFromApi();
  }

  Future<Tuple2<bool, String>> acceptInvite(int inviteId) async {
    try {
      final response = await invitesRestClient?.acceptInvite(inviteId);
      deleteInviteAndNotify(inviteId);
      return new Tuple2(true, response!.message);
    } on DioError catch (e) {
      return new Tuple2(false, e.response.data["message"]);
    }
  }

  Future<Tuple2<bool, String>> deleteInvite(int inviteId) async {
    try {
      final response = await invitesRestClient!.deleteInvite(inviteId);
      deleteInviteAndNotify(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      return new Tuple2(false, e.response.data["message"]);
    }
  }

  void deleteInviteAndNotify(int inviteId) {
    _invites.removeWhere((invite) => invite.id == inviteId);
    inviteRepository?.deleteById(inviteId);
    notifyListeners();
  }

  void getInvitesFromApi() async {
    final invites = await invitesRestClient?.getAllInvites();
    inviteRepository?.deleteAll();
    invites?.data?.invites?.forEach((inviteResponse) {
      inviteRepository!.insertInvite(
        inviteResponse.id,
        inviteResponse.message,
        inviteResponse.createdAt,
        inviteResponse.user?.id,
        inviteResponse.user?.firstName,
        inviteResponse.user?.lastName,
      );
    });

    _invites = await inviteRepository!.findAllInvites();
    _checkedFromApi = true;
    notifyListeners();
  }
}
