import 'package:flutter/material.dart';
import 'package:instagram_by_ary/resources/auth_methods.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
      username: '',
      uid: '',
      photoUrl: '',
      email: '',
      bio: '',
      followers: [],
      following: []);
  final AuthMethods _authMethods = AuthMethods();

  User get user => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
