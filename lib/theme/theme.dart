import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  static const MaterialColor accentcolor = MaterialColor(
    _accentcolorValue,
    <int, Color>{
      50: Color(0xff11323B),
      100: Color(0xff11323B),
      200: Color(0xff11323B),
      300: Color(0xff11323B),
      400: Color(0xff11323B),
      500: Color(_accentcolorValue),
      600: Color(0xff11323B),
      700: Color(0xff11323B),
      800: Color(0xff11323B),
      900: Color(0xff11323B),
    },
  );
  static const int _accentcolorValue = 0xff11323B;
  static const MaterialColor primarycolor = MaterialColor(
    _primarycolorValue,
    <int, Color>{
      50: Color(0xff4C7380),
      100: Color(0xff4C7380),
      200: Color(0xff4C7380),
      300: Color(0xff4C7380),
      400: Color(0xff4C7380),
      500: Color(_primarycolorValue),
      600: Color(0xff4C7380),
      700: Color(0xff4C7380),
      800: Color(0xff4C7380),
      900: Color(0xff4C7380),
    },
  );
  static const int _primarycolorValue = 0xff4C7380;
  final lightTheme = ThemeData.light().copyWith(
    iconTheme: IconThemeData(color: Colors.black87),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarycolor)
        .copyWith(background: Colors.white)
        .copyWith(secondary: Color(0xffD2D1D1))
        .copyWith(primary: accentcolor),
    primaryColor: primarycolor,
    appBarTheme: const AppBarTheme(),
    scaffoldBackgroundColor: Color(0xffD8E4E8),
    dividerColor: Colors.black12,
    shadowColor: Colors.black.withOpacity(0.07),
  );

  final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: accentcolor)
        .copyWith(background: Color(0xff100F0F))
        .copyWith(secondary: Color(0xffE2DCC8))
        .copyWith(primary: accentcolor),
    scaffoldBackgroundColor: Color(0xff100F0F),
    primaryColor: accentcolor,
    appBarTheme: const AppBarTheme(),
    dividerColor: Colors.white54,
    shadowColor: Colors.grey.withOpacity(0.07),
  );
  final _getStorage = GetStorage();

  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);

    saveThemeData(!isSavedDarkMode());
  }
}
