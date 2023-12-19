// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EditorThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF253127),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Color(0xFF253127)),
    colorScheme: const ColorScheme.light(
        onError: Colors.black,
        error: Colors.white,
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black),
    //-------------------------------Input Decoration
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white70),
      helperStyle: TextStyle(color: Colors.black54),
      labelStyle: TextStyle(color: Colors.black54),
      floatingLabelStyle: TextStyle(color: Colors.black54),
      // Set the text color for enabled state
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      // Set the text color for focused state
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    ),
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.black),
        contentTextStyle: TextStyle(color: Colors.black)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      headline2: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      headline3: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      headline4: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      headline5: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      headline6: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      subtitle1: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      subtitle2: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      bodyText1: TextStyle(color: Colors.black, fontFamily: 'Hind'),
      bodyText2: TextStyle(color: Colors.black, fontFamily: 'Hind'),
    ),
  );
}
