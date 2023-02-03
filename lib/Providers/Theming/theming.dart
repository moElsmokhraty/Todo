import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightMode = ThemeData(
      primaryColor: const Color(0xff5D9CEC),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff61E757)),
      scaffoldBackgroundColor: const Color(0xffDFECDB),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent
          ),
          elevation: 0,
          toolbarHeight:
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                      .size
                      .height *
                  0.15,
          titleSpacing: 20,
          backgroundColor: const Color(0xff5D9CEC),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          )));

  static ThemeData darkMode = ThemeData(
      primaryColor: const Color(0xff5D9CEC),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff61E757)),
      scaffoldBackgroundColor: const Color(0xff060E1E),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent
          ),
          elevation: 0,
          toolbarHeight:
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                      .size
                      .height *
                  0.15,
          titleSpacing: 20,
          backgroundColor: const Color(0xff5D9CEC),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          )));
}
