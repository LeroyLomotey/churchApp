import 'package:church_app/pages/menu/admin_page.dart';
import 'package:church_app/pages/menu/report_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'services/app_data.dart';

import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/home_page.dart';
import './pages/blog_viewer_page.dart';
import 'firebase_options.dart';
import 'pages/menu/about_page.dart';
import 'pages/menu/give_page.dart';
import 'pages/menu/contact_page.dart';

import 'services/themes.dart';

void main() async {
  //initialize firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  //initialize googe signin
  GoogleSignIn();

  runApp(
    const MyApp(), // Wrap your app
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppData data;
  @override
  void initState() {
    //Getting images from storage
    data = AppData();
    Future.delayed(Duration.zero).then((_) => data.fetchData());

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        //Go back to guest mode
        data.currentUser = AppUser();
      } else {
        const HomePage();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppData>(
          create: (_) => data,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ICGC Liberty Temple',
              theme: ThemeClass.lightTheme,
              routes: {
                '/': (context) => const LoginPage(),
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
