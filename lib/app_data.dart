import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:convert';

import 'blog.dart';
import 'event.dart';
import 'keys.dart';
import 'user.dart';

class AppData extends ChangeNotifier {
  final _eventsUrl = Uri.https(Keys.dbUrl, '/events.json');
  final _blogsUrl = Uri.https(Keys.dbUrl, '/blogs.json');

  var _storageRef;
  User _currentUser = User(name: 'Guest', email: 'guest');

  set currentUser(User user) => _currentUser = user;
  final List<Blog> _blogData = [];

  final List<String> _flyerData = [];

  final List<Event> _eventData = [];

  List<Blog> get blogData => _blogData;
  List<String> get flyerData => _flyerData;
  List<Event> get eventData => _eventData;

  void addEvent(Event event) {
    var body = {
      'title': event.title,
      'dateTime': event.dateTime.toString(),
      'description': event.description,
      'location': event.location,
      'recurring': event.recurring,
      'rsvp': event.rsvp,
    };
    http
        .post(
      _eventsUrl,
      body: json.encode(body),
    )
        .then(
      (response) async {
        var id = await json.decode(response.body)['name'];
        event.id = id;
        eventData.add(event);
        notifyListeners();
      },
    ).catchError((error) => print(error));
  }

  addBlog(Blog blog) {
    var body = {
      'title': blog.title,
      'body': blog.body,
      'date': blog.date,
      'imageURL': blog.image,
    };

    http
        .post(
      _blogsUrl,
      body: json.encode(body),
    )
        .then(
      (response) async {
        var id = await json.decode(response.body)['name'];
        blog.id = id;
        blogData.add(blog);
        notifyListeners();
      },
    ).catchError(
      (error) => print(error),
    );
  }

  addFlyer(var flyer) async {
    final flyersRef = _storageRef.child('flyers/${flyer.name}');
    File file = File(flyer.path);

    try {
      await flyersRef.putFile(file);
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      print(e);
    }
    return false;
  }

  fetchData() async {
    // _storageRef = FirebaseStorage.instance.ref();
    _fetchEvents();
    _fetchBlogs();
    // _fetchFlyers();
    notifyListeners();
  }

  _fetchEvents() async {
    try {
      final response = await http.get(_eventsUrl);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      extractData.forEach((key, value) {
        eventData.add(
          Event(
            id: key,
            title: value['title'],
            dateTime: value['dateTime'],
            description: value['description'],
            location: value['location'],
            recurring: value['recurring'],
            rsvp: value['rsvp'],
          ),
        );
      });
    } catch (error) {
      rethrow;
    }
  }

  _fetchBlogs() async {
    try {
      final response = await http.get(
        _blogsUrl,
      );
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      extractData.forEach(
        (key, value) {
          blogData.add(
            Blog(
                id: key,
                title: value['title'],
                body: value['body'],
                date: value['date'],
                image: value['imageURL']),
          );
        },
      );
    } catch (error) {
      rethrow;
    }

    print('blog data - $blogData');
  }

  _fetchFlyers() async {
    try {
      ListResult flyersList = await _storageRef.child('flyers').listAll();
      List.generate(flyersList.items.length, (index) async {
        final url = await flyersList.items[index].getDownloadURL();
        flyerData.add(url);
      });
    } on FirebaseException catch (e) {
      print(e);
    }
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
