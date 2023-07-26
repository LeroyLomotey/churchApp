// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/error_handling.dart';

import 'dart:convert';

import '../models/blog.dart';
import '../models/event.dart';
import '../keys.dart';
import '../models/user.dart';

class AppData extends ChangeNotifier {
  final _eventsUrl = Uri.https(Keys.dbUrl, '/events.json');
  final _blogsUrl = Uri.https(Keys.dbUrl, '/blogs.json');
  final _rsvpUrl = Uri.https(Keys.dbUrl, '/rsvp.json');
  final _storage = FirebaseStorage.instance;

  AppUser _currentUser = AppUser();

  final List<Blog> _blogData = [];

  final List<String> _flyerData = [];

  final List<Event> _eventData = [];
//----------------------------------------getters
  List<Blog> get blogData => _blogData;
  List<String> get flyerData => _flyerData;
  List<Event> get eventData => _eventData;
  AppUser get currentUser => _currentUser;

//-------------------------------------setters
  set currentUser(AppUser user) {
    _currentUser = user;
    notifyListeners();
  }

//----------------------------------------------------------------Add Data
  void addEvent(Event event, BuildContext context) async {
    var body = {
      'title': event.title,
      'dateTime': event.dateTime,
      'description': event.description,
      'location': event.location,
      'recurring': event.recurring,
      'rsvp': event.rsvp,
    };

    try {
      final response = await http.post(_eventsUrl, body: json.encode(body));
      var id = await json.decode(response.body)['name'];
      event.id = id;
      eventData.add(event);

      //create a new log for ppl who rsvp
      if (event.rsvp) {
        await http.put(_rsvpUrl, body: json.encode(event.id));
        final selectedUri = Uri.https(Keys.dbUrl, '/rsvp/${event.id}.json');
        await http.put(selectedUri, body: json.encode(event.title));
      }
      notifyListeners();
    } catch (e) {
      ErrorHandler().postReqMessage('event_fail', context);
      print('Error making POST request: $e');
    }
  }

  addBlog(Blog blog, BuildContext context) async {
    var body = {
      'title': blog.title,
      'body': blog.body,
      'date': blog.date,
      'imageURL': blog.image,
    };

    try {
      final response = await http.post(_blogsUrl, body: json.encode(body));
      var id = await json.decode(response.body)['name'];
      blog.id = id;
      blogData.add(blog);
      notifyListeners();
    } catch (e) {
      ErrorHandler().postReqMessage('blog_fail', context);
    }
  }

  addFlyer(var flyer, BuildContext context) async {
    try {
      final flyersRef = _storage.ref().child('flyers').child('${flyer.name}');
      final file = File(flyer.path);
      await flyersRef.putFile(file);
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      ErrorHandler().postReqMessage('flyer_fail', context);
      print(e);
    }
    return false;
  }

  addRSVP(Event event, context) async {
    var body = {
      currentUser.uid: currentUser.email,
    };

    try {
      final eventUri = Uri.https(Keys.dbUrl, '/rsvp/${event.id}.json');
      await http.patch(eventUri, body: json.encode(body));
    } on FirebaseException catch (e) {
      ErrorHandler().postReqMessage(e.code, context);
      print(e);
    }

    ErrorHandler().customMessage(
        'You have been successfully RSVP`d, see you soon!', context);
  }

//-------------------------------------------------------------Fetch Data
  fetchData() async {
    _fetchBlogs();
    _fetchFlyers();
  }

  fetchEvents() async {
    _eventData.clear();
    try {
      final eventResponse = await http.get(_eventsUrl);
      final eventExtractData =
          json.decode(eventResponse.body) as Map<String, dynamic>;

      final rsvpResponse = await http.get(_rsvpUrl);
      final rsvpExtractData =
          json.decode(rsvpResponse.body) as Map<String, dynamic>;

      eventExtractData.forEach((key, pair) {
        Event newEvent = Event(
          id: key,
          title: pair['title'],
          dateTime: pair['dateTime'],
          description: pair['description'],
          location: pair['location'],
          recurring: pair['recurring'],
          rsvp: pair['rsvp'],
        );
        //if uid is found in an event, update rsvpSelected = true
        if (rsvpExtractData.containsKey(key) &&
            rsvpExtractData[key][currentUser.uid] != null) {
          newEvent.rsvpSelected = true;
        }
        eventData.add(newEvent);
      });
      notifyListeners();
    } catch (error) {
      ErrorHandler().fetchReqMessage('event_fail');
      print(error);
    }
  }

  _fetchBlogs() async {
    _blogData.clear();
    try {
      final response = await http.get(_blogsUrl);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      extractData.forEach(
        (key, value) {
          Blog newBlog = Blog(
            id: key,
            title: value['title'],
            body: value['body'],
            date: value['date'],
          );
          //Workaround not being able to store null in firebase
          if (value['image'] != 'null') {
            newBlog.image = value['image'];
          }
          blogData.add(newBlog);
        },
      );
      notifyListeners();
    } catch (error) {
      ErrorHandler().fetchReqMessage('blog_fail');
      print(error);
    }
  }

  _fetchFlyers() async {
    _flyerData.clear();
    try {
      ListResult flyersList = await _storage.ref('flyers').listAll();
      List.generate(flyersList.items.length, (index) async {
        final url = await flyersList.items[index].getDownloadURL();
        flyerData.add(url);
      });
      notifyListeners();
    } on FirebaseException catch (error) {
      ErrorHandler().fetchReqMessage('flyer_fail');
      print(error);
    }
  }

//----------------------------------------Share files
  shareImage(String path) async {
    Share.shareXFiles([XFile(path)]);
  }

  shareBlog(String image, String title, String body) async {
    ByteData imagebyte = await rootBundle.load(image);
    Share.shareXFiles(
      [
        XFile.fromData(
          imagebyte.buffer.asUint8List(),
          mimeType: 'image/webp',
        ),
      ],
      subject: title,
      text: body,
    );
  }

//--------------------------------------------------delete
  resetdata() {
    _blogData.clear();
    _eventData.clear();
    _flyerData.clear();
  }

  removeRSVP(Event event, BuildContext context) {
    try {
      final rsvpSelectedUri =
          Uri.https(Keys.dbUrl, '/rsvp/${event.id}/${currentUser.uid}.json');
      http.delete(rsvpSelectedUri);
    } on FirebaseException catch (error) {
      ErrorHandler().customMessage('Failed to remove you from RSVP', context);
      print(error);
    }
  }

  removeBlog(Blog blog, BuildContext context) {
    try {
      final blogSelectedUri = Uri.https(Keys.dbUrl, '/blogs/${blog.id}.json');
      http.delete(blogSelectedUri);
    } on FirebaseException catch (error) {
      ErrorHandler().customMessage('Failed to remove blog', context);
      print(error);
    }
  }

  removeEvent(Event event, BuildContext context) {
    try {
      var blogSelectedUri = Uri.https(Keys.dbUrl, '/events/${event.id}.json');
      http.delete(blogSelectedUri);
      blogSelectedUri = Uri.https(Keys.dbUrl, '/rsvp/${event.id}.json');
      http.delete(blogSelectedUri);
    } on FirebaseException catch (error) {
      ErrorHandler().customMessage('Failed to remove blog', context);
      print(error);
    }
  }

  removeFlyer(String flyer, BuildContext context) async {
    try {
      await _storage.ref('flyers/$flyer').delete();
    } on FirebaseException catch (error) {
      ErrorHandler().customMessage('Failed to delete flyer', context);
      print(error);
    }
  }
//----------------------------------------------------misc

  Future<String> downloadImage(String imageURL) async {
    final uri = Uri.parse(imageURL);
    final res = await http.get(uri);
    final bytes = res.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);

    return path;
  }

  static String formatDate(String date) {
    String newDate = '${date.substring(8, 10)} ';
    switch (date.substring(5, 7)) {
      case '01':
        newDate += 'Jan';
        break;
      case '02':
        newDate += 'Feb';
        break;
      case '03':
        newDate += 'Mar';
        break;
      case '04':
        newDate += 'Apr';
        break;
      case '05':
        newDate += 'May';
        break;
      case '06':
        newDate += 'Jun';
        break;
      case '07':
        newDate += 'Jul';
        break;
      case '08':
        newDate += 'Aug';
        break;
      case '09':
        newDate += 'Sep';
        break;
      case '10':
        newDate += 'Oct';
        break;
      case '11':
        newDate += 'Nov';
        break;
      case '12':
        newDate += 'Dec';
    }
    newDate = '$newDate, ${date.substring(0, 4)}'; //ex 10 Jan 2023
    return newDate;
  }
}
