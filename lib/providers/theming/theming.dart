import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightMode = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary:  Colors.black,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    dialogBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      elevation: 0,
      titleSpacing: 20,
      backgroundColor: Color(0xff5D9CEC),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
  );

  static ThemeData darkMode = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.white,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xff060E1E),
    dialogBackgroundColor: const Color(0xff060E1E),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
