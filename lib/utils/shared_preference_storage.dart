import 'dart:convert' as Convert;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/models/user.dart';

class SharedPreferenceStorage {
  static const _key_user = "user";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setLoggedInUser(User? user) async {
    SharedPreferences prefs = await _prefs;
    if (user != null) {
      prefs.setString(_key_user, user.toString());
    } else {
      prefs.remove(_key_user);
    }
  }

  Future<User?> getLoggedInUser() async {
    SharedPreferences prefs = await _prefs;
    String? userString = prefs.getString(_key_user);
    if (userString != null)
      return User.fromMap(
        Convert.jsonDecode(userString) as Map<String, dynamic>,
      );
    else
      return null;
  }
}
