import 'package:flutter/material.dart';

Future<DateTime> datePicker(BuildContext context) async {
  DateTime? dateSelected = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    /*
    builder: (BuildContext context, Widget? child) {
      
      return Theme(
        data: Theme.of(context),
        child: child!,
      );
    },
    */
  );

  return dateSelected ?? DateTime.now();
}
