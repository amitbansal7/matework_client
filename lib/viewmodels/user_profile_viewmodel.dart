import 'dart:convert';

import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

import '../database.dart';

class UserProfileViewModel extends ChangeNotifier {
  late UserProfilesRestClient userProfilesRestClient;
  late AppDatabase db;

  set setAppDatabase(AppDatabase db) {
    this.db = db;
  }

  set setUserProfilesRestClient(UserProfilesRestClient userProfilesRestClient) {
    this.userProfilesRestClient = userProfilesRestClient;
  }

  Stream<UserProfile> getUserProfile(int id) {
    _getProfileFromApi(id);
    return db.findUserProfileById(id);
  }

  void _getProfileFromApi(int id) async {
    final response = await userProfilesRestClient.getProfileById(id);
    if (!response.success) {
      print("UserProfile not found ${id} -> ${response.message}");
      return;
    }

    final profile = response.data.profile;
    print(profile);
    final userProfile = UserProfilesCompanion(
      id: Value(profile.id),
      firstName: Value(profile.firstName),
      lastName: Value(profile.lastName),
      avatar: Value(profile.avatar),
      shortBio: Value(profile.shortBio),
      experience: Value(profile.experience),
      age: Value(profile.age),
      externalLink: Value(profile.externalLink),
      location: Value(profile.location),
      lookingFor: Value(profile.lookingFor),
      skills: Value(jsonEncode(profile.skills)),
    );
    db.createOrUpdateUseProfile(userProfile);
  }
}
