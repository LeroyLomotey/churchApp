import 'package:flutter/material.dart';

import 'blog_page.dart';
import '../pages/calendar_page.dart';
import '../pages/flyer_page.dart';
import '../pages/livestream_page.dart';

import '../widgets/custom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentTab = '/home';
  late final Map<String, Widget> tabs;

  @override
  initState() {
    tabs = {
      '/home': const BlogPage(),
      '/calendar': const CalendarPage(),
      '/flyers': const FlyerPage(),
      '/livestream': const StreamPage(),
    };
    super.initState();
  }

  changeTab(String newTab) {
    setState(() {
      currentTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    NavBar navBar = NavBar(changeTabFunction: changeTab);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Center(
            child: Image.asset('assets/images/logo.png',
                color: Colors.green.withOpacity(0.2))),
        tabs[currentTab]!,
        navBar,
      ]),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        // title: const Center(child: Text('Home')),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Image.asset('assets/icons/menu.png',
                    color:
                        Theme.of(context).appBarTheme.actionsIconTheme!.color));
          })
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: const Text('About Us'),
              onTap: () => Navigator.of(context).pushNamed('/aboutPage'),
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () => Navigator.of(context).pushNamed('/contactPage'),
            ),
            ListTile(
              title: const Text('Give'),
              onTap: () => Navigator.of(context).pushNamed('/givePage'),
            )
          ],
        ),
      ),
    );
  }
}
