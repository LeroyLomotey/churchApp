import '../services/app_data.dart';

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
      this.image = AppData.defaultLocal,
      required this.date});
}
