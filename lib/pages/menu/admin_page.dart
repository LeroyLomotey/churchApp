import 'dart:convert';

import 'package:church_app/models/blog.dart';
import 'package:church_app/widgets/event_editor_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../services/animation_manager.dart';
import '../../services/app_data.dart';
import '../../services/error_handling.dart';
import '../admin_tabs/blog_delete_page.dart';
import '../admin_tabs/blog_editor_page.dart';
import '../admin_tabs/event_editor_page.dart';
import '../admin_tabs/flyer_editor_page.dart';
import '../admin_tabs/video_editor_page.dart';
import 'menu_drawer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late String currentTab;
  late AnimationController _controller;
  late QuillController _quillController;
  late AppData data;
  late Map<String, Widget> tabs;
  bool initialBuild = true;
  bool floatingActionVisible = true;
  Icon floatingActionIcon = const Icon(Icons.save);

  @override
  void initState() {
    currentTab = '/blog';
    initialBuild = true;
    //Page transition controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _quillController = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
      onSelectionChanged: (value) {
        saveBlogText();
      },
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _quillController.dispose();
    super.dispose();
  }

  //data persistence for blog body text
  saveBlogText() {
    data.blogTextSaved =
        jsonEncode(_quillController.document.toDelta().toJson());
  }

  postData(BuildContext context) async {
    switch (currentTab) {
      case '/blog':
        {
          saveBlogText();
          String title = BlogEditorPage.title();
          if (title == "") {
            ErrorHandler().customMessage('Please enter a title', context);
          } else {
            await data.saveImage(BlogEditorPage.imagePicked(), context).then(
                (imageURL) => data.addBlog(
                    blog: Blog(
                        title: title,
                        body: data.blogTextSaved,
                        date: DateTime.now().toString(),
                        image: imageURL),
                    context: context));
          }
        }
        break;
      case '/event':
        {
          setState(() {
            eventEditorCard(context, data);
          });
        }
        break;
      case '/flyer':
        {
          data.addImage(context).then((file) => data.addFlyer(file, context));
        }
        break;
      case '/video':
        {
          data.updateStream(VideoEditorPage.link(), context);
        }
        break;
    }
  }

//plays animation when tab changes and saves blog data
  changeTab(String newTab) {
    if (currentTab == '/blog') {
      saveBlogText();
    }

    switch (newTab) {
      case '/blog':
        {
          floatingActionIcon = const Icon(Icons.save);
          floatingActionVisible = true;
        }
        break;
      case '/blogDelete':
        {
          floatingActionVisible = false;
        }
        break;
      case '/event':
        {
          floatingActionIcon = const Icon(Icons.add);
          floatingActionVisible = true;
        }
        break;
      case '/flyer':
        {
          floatingActionIcon = const Icon(Icons.add);
          floatingActionVisible = true;
        }
        break;
      case '/video':
        {
          floatingActionIcon = const Icon(Icons.save);
          floatingActionVisible = true;
        }
    }

    setState(() {
      _controller.reset();
      currentTab = newTab;
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    data = context.watch<AppData>();
    Size size = MediaQuery.of(context).size;

    if (initialBuild = true) {
      String initialText = data.blogTextSaved;
      _quillController.document = Document.fromJson((jsonDecode(initialText)));
      setState(() {
        initialBuild = false;
      });
    }
    _quillController.document.changes.listen((event) {});

    tabs = {
      '/blog': BlogEditorPage(controller: _quillController),
      '/blogDelete': const BlogDeletePage(),
      '/event': const EventEditorPage(),
      '/flyer': const FlyerEditorPage(),
      '/video': const VideoEditorPage(),
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        // title: const Center(child: Text('Home')),
        actions: [
          IconButton(
              onPressed: () => changeTab('/blog'),
              icon: const Icon(Icons.post_add),
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
          IconButton(
              onPressed: () => {changeTab('/blogDelete')},
              icon: const Icon(Icons.playlist_remove),
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
          IconButton(
              onPressed: () => changeTab('/event'),
              icon: const Icon(Icons.calendar_month),
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
          IconButton(
              onPressed: () => changeTab('/flyer'),
              icon: const Icon(Icons.add_photo_alternate),
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
          IconButton(
              onPressed: () => changeTab('/video'),
              icon: const Icon(Icons.video_call),
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color),
          Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: [
          Visibility(
            visible: floatingActionVisible,
            child: FloatingActionButton(
              tooltip: 'Save',
              onPressed: () => postData(context),
              child: floatingActionIcon,
            ),
          ),
        ],
      ),
      endDrawer: const MenuDrawer(),
    );
  }
}
