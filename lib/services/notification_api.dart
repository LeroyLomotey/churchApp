/*import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
}

class NotiicationAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifcations() async {
    await _firebaseMessaging.requestPermission();
    final fcMToken = await _firebaseMessaging.getToken();
    print('Token $fcMToken');
    FirebaseMessaging.onBackgroundMessage((backgroundMessage));
  }
}
*/