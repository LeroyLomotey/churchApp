class Event {
  String id;
  final String title;
  final String description;
  final String location;
  final String dateTime;
  final bool recurring;
  final bool rsvp;
  bool rsvpSelected;

  Event({
    this.id = '',
    required this.title,
    this.description = "See you soon!",
    required this.location,
    required this.dateTime,
    required this.recurring,
    required this.rsvp,
    this.rsvpSelected = false,
  });

  set _rsvpSelected(bool rsvpSelected) => this.rsvpSelected = rsvpSelected;
}
