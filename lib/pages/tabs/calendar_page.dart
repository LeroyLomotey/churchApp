import 'package:church_app/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../widgets/event_card.dart';
import 'package:church_app/services/app_data.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  List<Event> _selectedEvents = [];
  List<Event> eventData = [];

  List<Event> loadEvents(DateTime day) {
    return eventData.where((event) {
      var eventDay = DateTime.parse(event.dateTime);
      bool onSameDay = isSameDay(eventDay, day);
      bool recurring =
          (event.recurring == true) && (eventDay.weekday == day.weekday);
      return onSameDay || recurring;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    eventData = data.eventData;
    _selectedEvents = loadEvents(_focusedDay);
    return Column(children: [
      Container(
        color: Colors.transparent,
        child: TableCalendar(
          rowHeight: 40,
          selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          availableGestures: AvailableGestures.all,
          onDaySelected: (selectedDay, focusedDay) => {
            if (!isSameDay(_focusedDay, focusedDay))
              {
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedEvents = loadEvents(selectedDay);
                })
              }
          },
          eventLoader: (day) => loadEvents(day),
          //------------------------------------------------Styling
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
              cellMargin: const EdgeInsets.all(2),
              outsideDaysVisible: false,
              markerDecoration: BoxDecoration(
                  color: Colors.red.shade200, shape: BoxShape.circle),
              todayDecoration: const BoxDecoration(
                  color: Colors.black45, shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(
                  color: Colors.black45, shape: BoxShape.circle),
              rowDecoration: const BoxDecoration(color: Colors.transparent)),
        ),
      ),
      Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: _selectedEvents.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => eventCard(context, _selectedEvents[index], data),
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
                                _selectedEvents[index].title),
                            Text(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                AppData.formatDate(_focusedDay
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
                                _selectedEvents[index].location),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      )
    ]);
  }
}
