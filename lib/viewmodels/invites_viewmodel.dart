import 'dart:collection';

import 'package:Matework/models/invite.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

  Future<String?> acceptInvite(int inviteId) async {
    try {
      final response = await invitesRestClient?.acceptInvite(inviteId);
      if (response?.success == true) {
        _invites.removeWhere((invite) => invite.id == inviteId);
        inviteRepository?.deleteById(inviteId);
        notifyListeners();
        return null;
      } else {
        return response?.message;
      }
    } on DioError catch (e) {
      return e.response.data["message"];
    }
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
