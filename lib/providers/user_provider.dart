import 'package:flutter/material.dart';
import 'package:tourism/models/user.dart';
import 'package:tourism/utils/shared_preference_storage.dart';

class UserProvider with ChangeNotifier {
  final SharedPreferenceStorage storage = SharedPreferenceStorage();

  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  UserProvider() {
    getUserFromStorage();
  }

  Future<void> setLoggedInUser(User? user) async {
    this._loggedInUser = user;
    await storage.setLoggedInUser(user);
    notifyListeners();
  }

  Future<User?> getUserFromStorage() async {
    if (_loggedInUser != null) return _loggedInUser;
    _loggedInUser = await storage.getLoggedInUser();
    notifyListeners();
    return _loggedInUser;
  }
}
