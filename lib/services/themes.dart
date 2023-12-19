import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static Color darkmodeBackground = const Color(0xFF253127);
  static Color lightmodeBackground = const Color.fromRGBO(232, 245, 233, 1);
  static Color primaryColor = const Color.fromARGB(255, 196, 230, 199);
  static Color secondaryColor = Colors.green.shade300;
  static Color tertiaryColor = Colors.green.shade100;
  static Color complementColor = Colors.red.shade300;
  static Color complementColor2 = Colors.red.shade100;

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightmodeBackground,
    primaryColorDark: darkmodeBackground,
    //--------------------------------------Color Schene
    colorScheme: ColorScheme.light(
      onBackground: lightmodeBackground,
      background: Colors.white,
      primary: primaryColor,
      primaryContainer: lightmodeBackground,
      surface: Colors.white,
      secondary: lightmodeBackground,
    ),
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
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(complementColor),
      trackColor: MaterialStatePropertyAll(complementColor2),
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
    iconTheme: IconThemeData(size: 28, color: darkmodeBackground),
    //-------------------------Date picker theme
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: primaryColor,
      rangeSelectionBackgroundColor: primaryColor,
    ),
    //--------------------------FloatingActionButtion theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkmodeBackground,
      foregroundColor: Colors.white,
    ),
  );

  //-------------------------------------------------------------------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkmodeBackground,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme(
        onError: Colors.black,
        error: Colors.white,
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: lightmodeBackground,
        onSecondary: darkmodeBackground,
        background: Colors.white,
        onBackground: darkmodeBackground,
        surface: Colors.white,
        onSurface: Colors.white70),
    //-------------------------------Input Decoration
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white),
      helperStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.black54),
      floatingLabelStyle: TextStyle(color: Colors.black54),
    ),
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
      titleSmall: const TextStyle(color: Colors.white, fontFamily: 'Hind'),
      bodyLarge:
          TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: 'Hind'),
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
      labelLarge: const TextStyle(color: Colors.white70),
      labelMedium: const TextStyle(color: Colors.white70),
      labelSmall: const TextStyle(color: Colors.white70),
    ),
    //---------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      actionTextColor: darkmodeBackground,
      contentTextStyle: TextStyle(color: darkmodeBackground),
    ),
    hintColor: Colors.white70,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(secondaryColor),
      trackColor: MaterialStatePropertyAll(tertiaryColor),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: darkmodeBackground,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
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
    iconTheme: IconThemeData(size: 28, color: darkmodeBackground),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(darkmodeBackground))),
    primaryIconTheme: IconThemeData(size: 28, color: darkmodeBackground),
    //-------------------------Date picker theme

    datePickerTheme: DatePickerThemeData(
      backgroundColor: darkmodeBackground,
      headerBackgroundColor: darkmodeBackground,
      headerForegroundColor: Colors.white,
      rangeSelectionBackgroundColor: darkmodeBackground,
      surfaceTintColor: Colors.black54,
      dayStyle: const TextStyle(color: Colors.white),
      weekdayStyle: const TextStyle(color: Colors.white),
      yearStyle: const TextStyle(color: Colors.white),
      headerHeadlineStyle: const TextStyle(color: Colors.white),
      headerHelpStyle: const TextStyle(color: Colors.white),
      rangePickerHeaderHeadlineStyle: const TextStyle(color: Colors.white),
      rangePickerHeaderHelpStyle: const TextStyle(color: Colors.white),
      dayForegroundColor: const MaterialStatePropertyAll(Colors.white),
      //dayBackgroundColor:
    ),
    //--------------------------TimePicker theme

    //--------------------------FloatingActionButtion theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: darkmodeBackground,
        iconSize: 24),
  );
}

//ThemeClass _themeClass = ThemeClass();
