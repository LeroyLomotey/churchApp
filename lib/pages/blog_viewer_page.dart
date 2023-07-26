import 'package:church_app/models/event.dart';
import 'package:church_app/pages/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blog.dart';
import '../services/app_data.dart';

class BlogViewerPage extends StatelessWidget {
  const BlogViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Blog>;
    final currentBlog = args['blog'];
    final title = currentBlog!.title;
    final body = currentBlog.body;
    final date = currentBlog.date;
    final image = currentBlog.image;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          // title: const Center(child: Text('Home')),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                    data.addEvent(
                        Event(
                            title: 'test',
                            location: 'test',
                            dateTime: DateTime.now().toString(),
                            recurring: false,
                            rsvp: true),
                        context);
                  },
                  icon: Image.asset('assets/icons/menu.png',
                      color: Theme.of(context)
                          .appBarTheme
                          .actionsIconTheme!
                          .color));
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //---------------------------Share button
                Container(
                    width: size.width,
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black54, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () => data.shareBlog(image, title, body),
                            icon: const Icon(Icons.ios_share,
                                size: 25, color: Colors.white)))),
                //---------------------------------Title
                Text(title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(AppData.formatDate(date),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  //Check if the image is local or in firebase
                  child: image.substring(0, 6) == 'assets'
                      ? Image.asset(
                          image,
                          width: double.maxFinite,
                          height: 170,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          image,
                          width: double.maxFinite,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:
                      Text(body, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
        endDrawer: MenuDrawer(isAdmin: data.currentUser.isAdmin),
      ),
    );
  }
}
