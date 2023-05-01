import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'app_data.dart';

import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/home_page.dart';
import './pages/blog_viewer_page.dart';
import 'firebase_options.dart';
import 'pages/menu/about_page.dart';
import 'pages/menu/give_page.dart';
import 'pages/menu/contact_page.dart';

import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(), // Wrap your app
    ),
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
              useInheritedMediaQuery: false,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
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
                '/givePage': (context) => const GivePage(),
              },
            );
          },
        ),
      ],
    );
  }
}
