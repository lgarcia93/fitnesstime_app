import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static const String AuthorizationHeader = 'Authorization';
  static const String userName = 'UserName';
  static const String password = 'password';
  static const String userProfileJson = 'userProfileJson';

  static Future<void> setString(String key, String value) async {
    (await SharedPreferences.getInstance()).setString(key, value);
  }

  static Future<String> getString(String key) async {
    return (await SharedPreferences.getInstance()).getString(key);
  }
}
