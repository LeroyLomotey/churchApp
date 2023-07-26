import '../models/event.dart';

class EventManager {
  final List<Event> events;

  EventManager({required this.events});

  List<Event> get getEvents => events;

  addEvents(Event event) {
    events.add(event);
  }

  List<Event> eventsOnDay(DateTime day) {
    List<Event> eventsOnDay = [];

    for (Event e in events) {
      final date = DateTime.parse(e.dateTime);
      if (date.day == day.day) {
        eventsOnDay.add(e);
      }
    }
    return eventsOnDay;
  }

  //_sortEvents() {}

  _shrinkEvents() {
    for (Event e in events) {
      final date = DateTime.parse(e.dateTime);
      if (date.isBefore(DateTime.now())) {
        events.remove(e);
      }
      if (date.isAfter(DateTime.now())) {
        break;
      }
    }
  }
}
