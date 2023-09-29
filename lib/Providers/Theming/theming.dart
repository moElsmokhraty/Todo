import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightMode = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff61E757)),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      elevation: 0,
      titleSpacing: 20,
      backgroundColor: Color(0xff5D9CEC),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    ),
  );

  static ThemeData darkMode = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xff61E757),
    ),
    scaffoldBackgroundColor: const Color(0xff060E1E),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      elevation: 0,
      titleSpacing: 20,
      backgroundColor: Color(0xff5D9CEC),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.black,
      ),
    ),
  );
}
