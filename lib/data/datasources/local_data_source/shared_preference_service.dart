import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance!;
  }

  setUserRequestToken(String requestToken) {
    _instance?.setString(
        SharedPrefsKeyStrings.userRequestTokenKey, requestToken);
  }

  setSessionId(String sessionId) {
    _instance?.setString(SharedPrefsKeyStrings.userSessionIdKey, sessionId);
  }

  setUserAuthStatus(bool status) {
    _instance?.setBool(SharedPrefsKeyStrings.userAuthKey, status);
  }

  getUserRequestToken() {
    _instance?.getString(SharedPrefsKeyStrings.userRequestTokenKey);
  }

  getUserSessionId() {
    _instance?.getString(SharedPrefsKeyStrings.userSessionIdKey);
  }

  getUserAuthStatus() {
    _instance?.getBool(SharedPrefsKeyStrings.userAuthKey);
  }

  //for delete data
  static Future<bool> remove(String key) async => await _instance!.remove(key);

  static Future<bool> clear() async => await _instance!.clear();
}

class SharedPrefsKeyStrings {
  static String userAuthKey = 'auth';
  static String userRequestTokenKey = 'requestToken';
  static String userSessionIdKey = 'requestToken';
}
