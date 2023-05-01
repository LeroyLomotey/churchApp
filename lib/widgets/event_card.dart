import 'package:flutter/material.dart';

import '../themes.dart';
import '../app_data.dart';
import '../event.dart';

eventCard(BuildContext context, Event event) {
  bool rsvp = false;

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: const EdgeInsets.all(20),
          title: Text(
            event.title,
            style: const TextStyle(fontSize: 24.0),
          ),
          content: SizedBox(
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      AppData.formatDate(event.dateTime),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    event.description,
                    maxLines: 6,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      event.location,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  if (event.rsvp)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('RSVP'),
                          StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return Switch(
                              value: rsvp,
                              trackColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                return ThemeClass.complementColor2;
                              }),
                              thumbColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.white;
                                }
                                return ThemeClass.complementColor;
                              }),
                              activeThumbImage:
                                  Image.asset('assets/icons/check.png').image,
                              onChanged: (val) {
                                setState(() {
                                  rsvp = val;
                                });
                              },
                            );
                          }),
                        ]),
                ],
              ),
            ),
          ),
        );
      });
  /*
  return SizedBox(
      height: 300,
      width: 150,
      child: Card(
          color: Theme.of(context).primaryColor,
          child: Column(children: [
            Text(event.name),
            Text(AppData.formatDate(event.dateTime)),
            Text(event.location),
            Switch(value: event.recurring, onChanged: (val) => {})
          ])));
          */
}
