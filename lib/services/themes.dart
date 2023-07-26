import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static Color darkmodeBackground = const Color(0xFF253127);
  static Color primaryColor = Colors.green;
  static Color secondaryColor = Colors.green.shade300;
  static Color tertiaryColor = Colors.green.shade100;
  static Color complementColor = Colors.red.shade300;
  static Color complementColor2 = Colors.red.shade100;

  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.green.shade50,
      //----------------------------Text Styling
      textTheme: TextTheme(
        /*
        titleLarge: GoogleFonts.lobsterTwo(
          color: darkmodeBackground,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        */
        titleLarge: TextStyle(
          color: darkmodeBackground,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind',
        ),
        titleMedium: TextStyle(
          color: darkmodeBackground,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind,',
        ),
        bodyMedium: TextStyle(
          color: darkmodeBackground.withOpacity(0.8),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind',
        ),
        bodySmall: TextStyle(
          color: darkmodeBackground.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind',
        ),
      ),
      //---------------------App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        titleTextStyle: GoogleFonts.lobsterTwo(
          color: darkmodeBackground,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: darkmodeBackground),
        actionsIconTheme: IconThemeData(color: darkmodeBackground),
      ),
      //-----------------------Card theme
      cardTheme: CardTheme(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: const Color.fromARGB(121, 37, 49, 39),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      //-------------------------Icon theme
      iconTheme: IconThemeData(size: 28, color: darkmodeBackground));

  //-------------------------------------------------------------------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
      primaryColor: darkmodeBackground,
      //----------------------------Text Styling
      textTheme: TextTheme(
        titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind'),
        titleMedium: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind'),
        bodyMedium: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind'),
        bodySmall: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hind'),
      ),
      //---------------------App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: darkmodeBackground,
        elevation: 0,
        titleTextStyle: GoogleFonts.lobsterTwo(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      //-----------------------Card theme
      cardTheme: CardTheme(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      //-------------------------Icon theme
      iconTheme: const IconThemeData(size: 28, color: Colors.white));
}

//ThemeClass _themeClass = ThemeClass();
