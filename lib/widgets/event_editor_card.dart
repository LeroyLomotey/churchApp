import 'package:church_app/services/error_handling.dart';
import 'package:church_app/services/themes.dart';
import 'package:church_app/widgets/date_picker.dart';
import 'package:church_app/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../services/app_data.dart';

eventEditorCard(BuildContext context, AppData data) {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();
  final titleNode = FocusNode();
  final descNode = FocusNode();
  final locationNode = FocusNode();
  DateTime dateSelected =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TimeOfDay timeSelected = TimeOfDay.now();
  bool recurring = false;
  bool rsvp = false;

  Future<bool> saveEvent() async {
    final title = titleController.text;
    final desc = descController.text;
    final location = locationController.text;
    final dateTime = dateSelected
        .add(Duration(hours: timeSelected.hour, minutes: timeSelected.minute));
    if (title != '' && desc != '' && location != '') {
      Event event = Event(
        title: title,
        description: desc,
        dateTime: dateTime.toString(),
        location: location,
        recurring: recurring,
        rsvp: rsvp,
      );

      return await data.addEvent(event, context);
    } else {
      ErrorHandler()
          .customMessage('Please enter a title and description', context);
    }
    return false;
  }

  showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
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
          title: TextFormField(
            controller: titleController,
            focusNode: titleNode,
            decoration: const InputDecoration(hintText: 'Title'),
            style: const TextStyle(fontSize: 24.0),
            onEditingComplete: () => FocusScope.of(context).unfocus(),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: descController,
                  focusNode: descNode,
                  decoration: const InputDecoration(hintText: 'Description'),
                  maxLines: 6,
                  onEditingComplete: () =>
                      FocusScopeNode().requestFocus(locationNode),
                ),
                TextFormField(
                  controller: locationController,
                  focusNode: locationNode,
                  decoration: const InputDecoration(hintText: 'Location'),
                  maxLines: 3,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Need a stateful builder to update UI with user date and time selected, rsvp widget and recurring
                StatefulBuilder(builder: (context, StateSetter setState) {
                  return Column(
                    children: [
                      //--------------------------------------------------DatePicker
                      ListTile(
                        leading: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        subtitle: Text('Select a day',
                            style: Theme.of(context).textTheme.labelSmall),
                        title:
                            Text(DateFormat('yyyy-MM-dd').format(dateSelected)),
                        trailing: Icon(
                          Icons.expand_more,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await datePicker(context).then((value) {
                            setState(() {
                              dateSelected = value;
                            });
                          });
                        },
                      ),
                      //-----------------------------------------------TimePicker
                      ListTile(
                        leading: Icon(
                          Icons.schedule,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        subtitle: Text('Select a start time',
                            style: Theme.of(context).textTheme.labelSmall),
                        title: Text(timeSelected.format(context).toString()),
                        trailing: Icon(
                          Icons.expand_more,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await timePicker(context).then((value) {
                            setState(() {
                              timeSelected = value;
                            });
                          });
                        },
                      ),
                      //-------------------------------------------------Recurring
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Recurring'),
                          Switch(
                            onChanged: (value) => setState(() {
                              recurring = value;
                            }),
                            value: recurring,
                          ),
                        ],
                      ),
                      //-------------------------------------------------Recurring
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('RSVP'),
                          Switch(
                            onChanged: (value) => setState(() {
                              rsvp = value;
                            }),
                            value: rsvp,
                          ),
                        ],
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          actions: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ThemeClass.complementColor),
                    minimumSize: MaterialStatePropertyAll(Size(size.width, 40)),
                  ),
                  onPressed: () {
                    saveEvent().then((response) {
                      if (response) {
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Text('Save',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            ),
          ],
        );
      });
}
