import 'dart:collection';

import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/utils.dart';
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
    _invites = await inviteRepository!.findAllInvites();
    notifyListeners();
    getInvitesFromApi();
  }

  Future<Tuple2<bool, String>> acceptInvite(int inviteId) async {
    try {
      final response = await invitesRestClient?.acceptInvite(inviteId);
      deleteInviteAndNotify(inviteId);
      return new Tuple2(true, response!.message);
    } on DioError catch (e) {
      return new Tuple2(false, e.response?.data["message"] ?? SOMETHING_WRONG);
    }
  }

  Future<Tuple2<bool, String>> deleteInvite(int inviteId) async {
    try {
      final response = await invitesRestClient!.deleteInvite(inviteId);
      deleteInviteAndNotify(inviteId);
      return new Tuple2(true, response.message);
    } on DioError catch (e) {
      return new Tuple2(false, e.response?.data["message"] ?? SOMETHING_WRONG);
    }
  }

  void deleteInviteAndNotify(int inviteId) {
    _invites.removeWhere((invite) => invite.id == inviteId);
    inviteRepository?.deleteById(inviteId);
    notifyListeners();
  }

  void getInvitesFromApi() async {
    try {
      final invites = await invitesRestClient?.getAllInvites();
      inviteRepository?.deleteAll();
      invites?.data?.invites?.forEach((inviteResponse) {
        inviteRepository!.insertInvite(
          Invite(
            id: inviteResponse.id,
            message: inviteResponse.message,
            createdAt: inviteResponse.createdAt,
            userId: inviteResponse.user?.id,
            userFirstName: inviteResponse.user?.firstName,
            userLastName: inviteResponse.user?.lastName,
            userAvatar: inviteResponse.user?.avatar,
          ),
        );
      });

      _invites = await inviteRepository!.findAllInvites();
    } on DioError catch (e) {}
    _checkedFromApi = true;
    notifyListeners();
  }
}
