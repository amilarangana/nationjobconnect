import 'dart:convert';

import 'package:nation_job_connect/authentication/models/user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefs{
 late final SharedPreferences sharedPrefs;
  final String _PREF_USER_CREDENTIAL = "prefs_user_credentials";

  static final AuthSharedPrefs _instance = AuthSharedPrefs._internal();

  factory AuthSharedPrefs() => _instance;

  AuthSharedPrefs._internal();

  Future init() async{
    sharedPrefs = await SharedPreferences.getInstance();
  }

  Future<bool> storeUserCredentials(UserCredentials userCredentials) async {
    return sharedPrefs.setString(_PREF_USER_CREDENTIAL, jsonEncode(userCredentials.toJson()) );
  }

  UserCredentials? retrieveSavedUserCredentials() { 
    var userCredentialsJson = sharedPrefs.getString(_PREF_USER_CREDENTIAL);
    if (userCredentialsJson != null) {
      return UserCredentials.fromJson(jsonDecode(userCredentialsJson)) ;
    }
    return null;
  }
}