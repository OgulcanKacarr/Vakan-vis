import 'package:flutter/material.dart';

class ThemeClass {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey[900],
    hintColor: Colors.white,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white, // Dark theme button color
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white70),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    hintColor: Colors.black,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Light theme button color
      textTheme: ButtonTextTheme.primary,
    ),
  );
}