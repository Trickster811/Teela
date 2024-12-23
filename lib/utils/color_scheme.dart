import 'package:flutter/material.dart';
import 'package:teela/utils/local.dart';

// Primary Color Scheme
const primary100 = Color(0xFFF9AEAE);
const primary200 = Color(0xFFF25D5D);
const primary300 = Color(0xFFED2424);
const primary400 = Color(0xFFC41010);
const primary500 = Color(0xFF8A0B0B);
const primaryAlpha10 = Color.fromARGB(10, 242, 93, 93);

// Secondary Color Scheme
const secondary100 = Color(0xFFDAf2AF);
const secondary200 = Color(0xFFB5E45E);
const secondary300 = Color(0xFF9EDB2B);
const secondary400 = Color(0xFF7BAE1D);
const secondary500 = Color(0xFF577B15);
const secondaryAlpha10 = Color.fromARGB(10, 181, 228, 94);

// Neutral Color Scheme
const neutral100 = Color(0xFFFFFFFF);
const neutral200 = Color(0xFFE8E8E8);
const neutral300 = Color(0xFFD2D2D2);
const neutral400 = Color(0xFFBBBBBB);
const neutral500 = Color(0xFFA4A4A4);
const neutral600 = Color(0xFF8E8E8E);
const neutral700 = Color(0xFF777777);
const neutral800 = Color(0xFF606060);
const neutral900 = Color(0xFF4A4A4A);
const neutral1000 = Color(0xFF333333);
const neutralAplpha10 = Color.fromARGB(10, 51, 51, 51);

// Red Color Scheme
const red100 = Color(0xFFFB3748);
const red200 = Color(0xFFD00416);
const redAlpha = Color.fromARGB(10, 251, 55, 72);

// Yellow Color Scheme
const yellow100 = Color(0xFFFFDB43);
const yellow200 = Color(0xFFDFB400);
const yellowAlpha = Color.fromARGB(10, 255, 219, 67);

// Green Color Scheme
const green100 = Color(0xFF84EBB4);
const green200 = Color(0xFF1FC16B);
const greenAlpha = Color(0x091FC16B);

class MyThemes {
  // Dark Theme Configurations
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: primary500,
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
      ),
    ),
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Colors.white),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
  );

  // Light Theme Configurations
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
      ),
    ),
    primaryColor: primary500,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(
      color: Color.fromRGBO(5, 35, 61, 1),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  );
}

class ThemeProvider extends ChangeNotifier {
  static int? isDark;

  static Future init() async {
    isDark = LocalPreferences.getTheme();
  }

  ThemeMode themeMode =
      isDark == null || isDark == 0 ? ThemeMode.light : ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    isDark = isOn ? 1 : 0;
    LocalPreferences.setTheme(isOn ? 1 : 0);
    notifyListeners();
    // final theme = await SharedPreferences.getInstance();
    // theme.setBool('isDark', isOn);
  }
}
