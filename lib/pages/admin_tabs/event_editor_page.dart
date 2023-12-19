import 'package:church_app/widgets/alert.dart';
import 'package:church_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';
import '../../services/themes.dart';

class EventEditorPage extends StatefulWidget {
  const EventEditorPage({super.key});

  @override
  State<EventEditorPage> createState() => _EventEditorPageState();
}

class _EventEditorPageState extends State<EventEditorPage> {
  @override
  Widget build(BuildContext context) {
    AppData data = context.watch<AppData>();
    Size size = MediaQuery.of(context).size;
    final eventData = data.eventData;

    return Container(
      color: Theme.of(context).primaryColor,
      height: size.height,
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: eventData.length,
          itemBuilder: (context, index) {
            String key = eventData[index].id;
            return Dismissible(
              key: Key(key),
              confirmDismiss: (direction) {
                return createAlert(
                    title: eventData[index].title,
                    content: 'Are you sure you want to delete this?',
                    noFunction: () {},
                    yesFunction: () =>
                        data.removeEvent(eventData[index], context),
                    context: context);
              },
              onDismissed: (direction) {
                eventData.removeWhere((event) => event.id == key);
              },
              child: GestureDetector(
                onTap: () {
                  eventCard(context, eventData[index], data);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: ThemeClass.darkmodeBackground,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                eventData[index].title),
                            Text(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                AppData.formatDate(eventData[index]
                                    .dateTime
                                    .toString())), //'${_selectedEvents[index].dateTime.hour} : ${_selectedEvents[index].dateTime.minute} ${_selectedEvents[index].dateTime.}')
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 2,
                                eventData[index].location),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
