import 'package:flutter/material.dart';

import '../services/themes.dart';

Future<bool> createAlert({
  required String title,
  required String content,
  required Function noFunction,
  required Function yesFunction,
  required BuildContext context,
}) async {
  return await showDialog(
          context: context,
          builder: (context) {
            Size size = MediaQuery.of(context).size;
            return AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(title),
              content: Text(content),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: TextButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStatePropertyAll(Size(size.width / 4, 20))),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      noFunction();
                    },
                    child: Text(
                      "NO",
                      style: TextStyle(color: ThemeClass.complementColor),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: TextButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(
                              Size(size.width / 4, 20))),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        yesFunction();
                      },
                      child: const Text("YES",
                          style: TextStyle(
                              color: Color.fromARGB(255, 94, 161, 65)))),
                ),
              ],
            );
          }) ??
      false;
}
