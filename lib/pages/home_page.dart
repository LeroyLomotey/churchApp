import 'package:church_app/pages/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/animation_manager.dart';
import '../services/app_data.dart';
import 'tabs/blog_page.dart';
import 'tabs/calendar_page.dart';
import 'tabs/flyer_page.dart';
import 'tabs/livestream_page.dart';

import '../widgets/custom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late String currentTab;
  late AnimationController _controller;
  late final Map<String, Widget> tabs;

  @override
  initState() {
    currentTab = '/Home';
    tabs = {
      '/Home': const BlogPage(),
      '/Calendar': const CalendarPage(),
      '/Flyers': const FlyerPage(),
      '/Livestream': const StreamPage(),
    };
    //Page transition controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//plays animation when tab changes
  changeTab(String newTab) {
    setState(() {
      _controller.reset();
      currentTab = newTab;
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size screenSize = MediaQuery.of(context).size;
    NavBar navBar = NavBar(changeTabFunction: changeTab);
    return WillPopScope(
      //Prevents back button from going to empty stack
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(children: [
            Center(
                child: Image.asset('assets/images/logo.png',
                    color: Colors.green.withOpacity(0.2))),
            AnimationManager().tabTransition(
                controller: _controller,
                child: tabs[currentTab]!,
                size: screenSize),
            navBar,
          ]),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: Center(child: Text(currentTab.substring(1))),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Image.asset('assets/icons/menu.png',
                        color: Theme.of(context)
                            .appBarTheme
                            .actionsIconTheme!
                            .color));
              })
            ],
          ),
          endDrawer: MenuDrawer(isAdmin: data.currentUser.isAdmin),
        ),
      ),
    );
  }
}
