import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';

class AppProfile extends ChangeNotifier {
  ProfileUser? _profileUser;
  ProfileUser? get profileUser => _profileUser;
  set profileUser(ProfileUser? profileUser) {
    _profileUser = profileUser;
    notifyListeners();
  }

  void fetchProfileUser(ProfileUser? profileUser) {
    _profileUser = profileUser;
  }
}
