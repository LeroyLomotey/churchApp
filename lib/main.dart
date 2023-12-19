import 'package:church_app/pages/menu/admin_page.dart';
import 'package:church_app/pages/menu/report_page.dart';
import 'package:church_app/services/authentication.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:church_app/services/themes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'services/app_data.dart';

import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/home_page.dart';
import './pages/blog_viewer_page.dart';
import 'firebase_options.dart';
import 'pages/menu/about_page.dart';
import 'pages/menu/give_page.dart';
import 'pages/menu/contact_page.dart';

void main() async {
  //initialize firebase app
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //initialize mobile ads
  MobileAds.instance.initialize();
  //Screen orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Connect to notification API
  //await NotiicationAPI().initNotifcations();
  //Keeps splash screen until manually removed
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize googe signin
  GoogleSignIn();

  runApp(
    const MyApp(), // Wrap your app
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppData data = AppData();

  checkUser() {
    final user = Authentication().currentUser;
    if (user == null) {
      FlutterNativeSplash.remove();
    } else {
      FlutterNativeSplash.remove();
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => data.fetchData());

    //FF FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppData>(
          create: (_) => data,
          builder: (context, child) {
            data = context.watch<AppData>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ICGC Liberty Temple',
              theme: context.watch<AppData>().darkMode
                  ? ThemeClass.darkTheme
                  : ThemeClass.lightTheme,
              routes: {
                '/': (context) =>
                    checkUser() == null ? const LoginPage() : const HomePage(),
                '/loginPage': (context) => const LoginPage(),
                '/registerPage': (context) => const RegisterPage(),
                '/homePage': (context) => const HomePage(),
                '/blogViewerPage': (context) => const BlogViewerPage(),
                '/aboutPage': (context) => const AboutPage(),
                '/contactPage': (context) => const ContactPage(),
                '/reportPage': (context) => const ReportPage(),
                '/givePage': (context) => const GivePage(),
                '/adminPage': (context) => const AdminPage(),
              },
            );
          },
        ),
      ],
    );
  }
}
