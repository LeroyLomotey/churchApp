// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';

import '../services/error_handling.dart';
import '../models/blog.dart';
import '../models/event.dart';
import '../keys.dart';
import '../models/user.dart';
import 'authentication.dart';

class AppData extends ChangeNotifier {
  static final _eventsUrl = Uri.https(Keys.dbUrl, '/events.json');
  static final _blogsUrl = Uri.https(Keys.dbUrl, '/blogs.json');
  static final _rsvpUrl = Uri.https(Keys.dbUrl, '/rsvp.json');
  static final _streamUrl = Uri.https(Keys.dbUrl, '/liveStream.json');
  static final _adminsUrl = Uri.https(Keys.dbUrl, '/admins.json');
  final _storage = FirebaseStorage.instance;
  final _realtimeDB = FirebaseDatabase.instance;
  AppUser _currentUser = AppUser();

  final List<Blog> _blogData = [];
  final List<String> _flyerData = [];
  final List<Event> _eventData = [];
  String _streamLink = 'https://www.youtube.com/watch?v=_CpaPejLY9M';

//Data persistence for blog editor, in case user switches tab without saving
  String _blogTextSaved = r'[{"insert":"\n"}]';

  //For default variables
  static const defaultNetwork =
      'https://upload.wikimedia.org/wikipedia/commons/2/25/Icon-round-Question_mark.jpg';
  static const defaultLocal = 'assets/images/logo.png';
  static const defaultVideo = '_T-rpRFn_CI';
//Theme selected
  bool _darkMode = false;
//----------------------------------------getters
  List<Blog> get blogData => _blogData;
  List<String> get flyerData => _flyerData;
  List<Event> get eventData => _eventData;
  String get streamLink => _streamLink;
  AppUser get currentUser => _currentUser;
  String get blogTextSaved => _blogTextSaved;
  bool get darkMode => _darkMode;

//-------------------------------------setters
  set streamLink(link) {
    _streamLink = link;
    notifyListeners();
  }

  set darkMode(value) {
    _darkMode = value;
    notifyListeners();
  }

  set currentUser(AppUser user) {
    _currentUser = user;
    notifyListeners();
  }

  set blogTextSaved(String text) {
    _blogTextSaved = text;
  }

//----------------------------------------------------------------Add Data
  Future<bool> addEvent(Event event, BuildContext context) async {
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
        await http.patch(_rsvpUrl, body: json.encode(event.id));
        final selectedUri = Uri.https(Keys.dbUrl, '/rsvp/${event.id}.json');
        await http.patch(selectedUri, body: json.encode(event.title));
      }
      notifyListeners();
    } catch (e) {
      ErrorHandler().postReqMessage('event_fail', context);
      print('Error making POST request: $e');
      return false;
    }
    ErrorHandler().customMessage('Successfully added event', context);
    return true;
  }

  addBlog({required Blog blog, required BuildContext context}) async {
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
      blogData.insert(0, blog);
      notifyListeners();
    } catch (e) {
      ErrorHandler().postReqMessage('blog_fail', context);
    }
    ErrorHandler().customMessage('Successfully added blog', context);
  }

  addFlyer(File flyer, BuildContext context) async {
    final name = flyer.path.split('/').last;
    try {
      final flyersRef = _storage.ref().child('flyers').child(name);
      if (!await imageExists(flyersRef)) {
        await flyersRef.putFile(flyer);
        final url = await flyersRef.getDownloadURL();
        flyerData.insert(0, url);
        notifyListeners();
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
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

  Future<File> addImage(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        return imageFile;
      }
    } catch (error) {
      ErrorHandler().customMessage('No image was selected', context);
      print(error);
    }

    return File('null');
  }

  Future<String> saveImage(File image, BuildContext context) async {
    if (image.existsSync()) {
      try {
        final imageRef =
            _storage.ref('images/${DateTime.now().toString()}.jpg');
        await imageRef.putFile(image);
        return imageRef.getDownloadURL();

        // final response = _storage.ref('/images/${DateTime.now().toString()}')
      } on FirebaseException catch (error) {
        ErrorHandler().customMessage(error.code, context);
        print(error);
      }
    }

    return 'null';
  }

//-------------------------------------------------------------Fetch Data
  fetchData() async {
    if (Authentication().currentUser != null) {
      currentUser.uid = Authentication().currentUser!.uid;
      currentUser.isAdmin = await isAdmin(currentUser.uid);
      print('user ${currentUser.uid} admin is ${currentUser.isAdmin}');
    }

    _fetchBlogs();
    _fetchFlyers();
    _fetchLiveStream();
    fetchEvents();
    // listenForUpdates();
  }

  void listenForUpdates() {
    _realtimeDB.ref('/liveStream').onValue.listen((event) {
      _fetchLiveStream();
    });
    _realtimeDB.ref('/blogs').onValue.listen((event) {
      _fetchBlogs();
    });
    _realtimeDB.ref('/events').onValue.listen((event) {
      fetchEvents();
    });
  }

  _fetchLiveStream() async {
    try {
      final response = await http.get(_streamUrl);
      final extractData = json.decode(response.body) as Map<String, dynamic>?;
      streamLink = extractData?['link'];
    } catch (e) {
      ErrorHandler().fetchReqMessage('stream_fail');
    }
  }

  fetchEvents() async {
    _eventData.clear();
    try {
      final eventResponse = await http.get(_eventsUrl);
      final eventExtractData =
          json.decode(eventResponse.body) as Map<String, dynamic>?;

      final rsvpResponse = await http.get(_rsvpUrl);
      final rsvpExtractData =
          json.decode(rsvpResponse.body) as Map<String, dynamic>?;

      eventExtractData?.forEach((key, pair) {
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
        if (rsvpExtractData!.containsKey(key) &&
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
          if (value['imageURL'] != 'null') {
            newBlog.image = value['imageURL'];
          }
          blogData.add(newBlog);
          blogData.sort((a, b) => a.date.compareTo(b.date));
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

  //----------------------------------------------Patch/update data
  updateStream(String link, BuildContext context) async {
    var body = {
      'link': link,
    };
    try {
      //final uri = Uri.https(Keys.dbUrl, '/liveStream/link.json');
      await http.put(_streamUrl, body: json.encode(body));
      streamLink = link;
      ErrorHandler().customMessage('Successfully Updated Stream', context);
      notifyListeners();
    } catch (error) {
      ErrorHandler().customMessage('Unable to update stream', context);
    }
  }

//----------------------------------------Share files
  shareImage(String path) async {
    Share.shareXFiles([XFile(path)]);
  }

  shareBlog(String image, String title, String body) async {
    try {
      Share.shareXFiles(
        [XFile(image)],
        subject: title,
        text: body,
      );
    } catch (error) {
      print(error);
      Share.share(
        body,
        subject: title,
      );
    }
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

  bool removeBlog(Blog blog, BuildContext context) {
    try {
      blogData.removeWhere((element) => element.id == blog.id);
      notifyListeners();
      final blogSelectedUri = Uri.https(Keys.dbUrl, '/blogs/${blog.id}.json');
      http.delete(blogSelectedUri);
      Uri uri = Uri.parse(blog.image);
      String imagePath = uri.path;
      String imageName =
          Uri.decodeComponent(imagePath.split('/').last).substring(7);
      print(imageName);
      _storage.ref('images').child('/$imageName').delete();
      return true;
    } catch (error) {
      ErrorHandler().customMessage('Failed to remove blog', context);
      print(error);
    }
    ErrorHandler().customMessage('Successfully removed blog', context);
    return false;
  }

  removeEvent(Event event, BuildContext context) {
    try {
      var eventSelectedUri = Uri.https(Keys.dbUrl, '/events/${event.id}.json');
      http.delete(eventSelectedUri);
      eventSelectedUri = Uri.https(Keys.dbUrl, '/rsvp/${event.id}.json');
      http.delete(eventSelectedUri);
      eventData.removeWhere((element) => event.id == element.id);
      notifyListeners();
    } catch (error) {
      ErrorHandler().customMessage('Failed to remove blog', context);
      print(error);
    }
    ErrorHandler().customMessage('Event removed successfuly', context);
  }

  removeFlyer(String flyer, BuildContext context) async {
    try {
      Uri uri = Uri.parse(flyer);
      String imagePath = uri.path;
      String imageName =
          Uri.decodeComponent(imagePath.split('/').last).substring(7);
      print(imageName);
      await _storage.ref('flyers').child('/$imageName').delete();
      flyerData.remove(flyer);
      notifyListeners();
    } catch (error) {
      ErrorHandler().customMessage('Failed to delete flyer', context);
      print(error);
    }
    ErrorHandler().customMessage('Successfully removed flyer', context);
  }

//----------------------------------------------------misc

  static Future<bool> isAdmin(String uid) async {
    final response = await http.get(_adminsUrl);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    return extractData.containsKey(uid);
  }

  Future<bool> imageExists(Reference ref) async {
    try {
      await ref.getDownloadURL();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<String> downloadImage(String imageURL) async {
    if (imageURL.substring(0, 6) == 'assets') return imageURL;
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
