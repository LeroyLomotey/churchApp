class Blog {
  String id;
  final String title;
  final String body;
  String image;
  final String date;

  Blog(
      {this.id = '',
      required this.title,
      required this.body,
      this.image = 'assets/images/reader.png',
      required this.date});
}
