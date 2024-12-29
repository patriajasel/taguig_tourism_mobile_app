import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier {
  String? _profileImageURL;

  String? get profileImageURL => _profileImageURL;

  void updateProfileImage(String url) {
    _profileImageURL = url;
    notifyListeners();
  }
}