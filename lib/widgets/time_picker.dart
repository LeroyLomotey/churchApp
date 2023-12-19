import 'package:flutter/material.dart';

Future<TimeOfDay> timePicker(BuildContext context) async {
  TimeOfDay? timeSelected = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    /*
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                // change the border color
                primary: Theme.of(context).primaryColor,
                // change the text color
                onSurface: Colors.white,
              ),
              // button colors
              buttonTheme: const ButtonThemeData(
                colorScheme: ColorScheme.dark(
                  primary: Colors.white,
                ),
              ),
            ),
            child: child!);
      }
      */
  );

  return timeSelected ?? TimeOfDay.now();
}
