import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/animation_manager.dart';
import '../../services/app_data.dart';
import '../admin_tabs/blog_editor_page.dart';
import '../admin_tabs/event_editor_page.dart';
import '../admin_tabs/flyer_editor_page.dart';
import '../admin_tabs/video_editor_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late String currentTab;
  late AnimationController _controller;
  late final Map<String, Widget> tabs;

  @override
  void initState() {
    currentTab = '/blog';
    tabs = {
      '/blog': const BlogEditorPage(),
      '/event': const EventEditorPage(),
      '/flyer': const FlyerEditorPage(),
      '/video': const VideoEditorPage(),
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          // title: const Center(child: Text('Home')),
          actions: [
            IconButton(
                onPressed: () => changeTab('/blog'),
                icon: const Icon(Icons.description),
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
            IconButton(
                onPressed: () => changeTab('/event'),
                icon: const Icon(Icons.calendar_month),
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
            IconButton(
                onPressed: () => changeTab('/flyer'),
                icon: const Icon(Icons.collections),
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
            IconButton(
                onPressed: () => changeTab('/video'),
                icon: const Icon(Icons.videocam),
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.person),
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
            Builder(
              builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                      /*
                    data.addEvent(
                        Event(
                            title: 'test',
                            location: 'test',
                            dateTime: DateTime.now().toString(),
                            recurring: false,
                            rsvp: true),
                        context);
                        */
                    },
                    icon: Image.asset('assets/icons/menu.png',
                        color: Theme.of(context)
                            .appBarTheme
                            .actionsIconTheme!
                            .color));
              },
            )
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: AnimationManager().tabTransition(
              controller: _controller, child: tabs[currentTab]!, size: size),
        ));
  }
}
