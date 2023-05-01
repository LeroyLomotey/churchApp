import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../blog.dart';
import '../event.dart';
import '../app_data.dart';

class BlogViewerPage extends StatelessWidget {
  const BlogViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Blog>;
    final currentBlog = args['blog'];
    final title = currentBlog!.title;
    final body = currentBlog.body;
    final date = currentBlog.date;
    final image = currentBlog.image;
    AppData data = AppData();

    shareBlog() async {
      ByteData imagebyte = await rootBundle.load(image);
      Share.shareXFiles(
        [
          XFile.fromData(
            imagebyte.buffer.asUint8List(),
            mimeType: 'image/webp',
          ),
        ],
        subject: title,
        text: body,
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          // title: const Center(child: Text('Home')),
          actions: [
            IconButton(
                onPressed: () {
                  Event event = Event(
                    title: 'Faith Walk',
                    description:
                        'wjeqrq qejqwr rqirwqriq qweqwrn qrnq qqn e rer',
                    location: 'Orange',
                    dateTime: DateTime.now().toString(),
                    recurring: false,
                    rsvp: true,
                  );
                  data.addEvent(event);
                },
                icon: Image.asset('assets/icons/menu.png',
                    color:
                        Theme.of(context).appBarTheme.actionsIconTheme!.color))
          ],
        ),
        body: Padding(
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
                          onPressed: () => shareBlog(),
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
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset.fromDirection(1.5),
                        blurRadius: 5,
                        spreadRadius: 0,
                      )
                    ]),
                child: Image.asset(
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
        ));
  }
}
