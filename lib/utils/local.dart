import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static late SharedPreferences _preferences;
  static final messagerKey = GlobalKey<ScaffoldMessengerState>();
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
  static showFlashMessage(String message, Color color) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      closeIconColor: color,
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      content: Container(
        height: 40,
        // width: deviceSize.width,
        margin: const EdgeInsets.all(10), padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    messagerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
