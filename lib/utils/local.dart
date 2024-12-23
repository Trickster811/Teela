import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static late SharedPreferences _preferences;
  static const themeMode = 'isDark';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTheme(int isDark) async {
    await _preferences.setInt(themeMode, isDark);
  }

  static int? getTheme() => _preferences.getInt(themeMode);

  static Future setFirstTime(bool firstTime) async {
    await _preferences.setBool('firstTime', firstTime);
  }

  static bool? getFirstTime() => _preferences.getBool('firstTime');

  static Future setUserInfo(Map<String, dynamic> userInfo) async {
    await _preferences.setString('userInfo', jsonEncode(userInfo));
    return getUserInfo();
  }

  static Map<String, dynamic> getUserInfo() =>
      jsonDecode(_preferences.getString('userInfo') ?? "{}");

  static Future setAppLanguage(String appLanguage) async {
    await _preferences.setString('appLanguage', appLanguage);
  }

  static String getAppLanguage() =>
      _preferences.getString('appLanguage') ?? 'en';
}
