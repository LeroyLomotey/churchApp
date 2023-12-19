import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/blog.dart';
import '../../services/app_data.dart';
import '../../widgets/alert.dart';

class BlogDeletePage extends StatefulWidget {
  const BlogDeletePage({super.key});

  @override
  State<BlogDeletePage> createState() => _BlogDeletePageState();
}

class _BlogDeletePageState extends State<BlogDeletePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppData data = context.read<AppData>();
    List<Blog> blogData = data.blogData.reversed.toList();
    return Container(
      color: Theme.of(context).primaryColor,
      height: size.height,
      child: ListView.builder(
          padding:
              const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 80),
          itemCount: blogData.length,
          itemBuilder: (context, index) {
            var image = blogData[index].image;
            if (image.length < 5 || image == 'null') {
              image = AppData.defaultLocal;
            }
            var key = blogData[index].id;
            return Dismissible(
              key: Key(key),
              confirmDismiss: (direction) {
                return createAlert(
                    title: blogData[index].title,
                    content: 'Are you sure you want to delete this?',
                    noFunction: () {},
                    yesFunction: () =>
                        data.removeBlog(blogData[index], context),
                    context: context);
              },
              onDismissed: (direction) {
                blogData.removeWhere((blog) => blog.id == key);
              },
              child: Container(
                width: size.width,
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Container(
                              width: 100, height: 100, color: Colors.white),
                          image.substring(0, 6) == 'assets'
                              ? Image.asset(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  image)
                              : Image.network(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  image,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      AppData.defaultNetwork,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, top: 8, left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Daily Devotional",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(
                                  maxLines: 2,
                                  blogData[index].title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Text(
                                  maxLines: 1,
                                  AppData.formatDate(
                                    blogData[index].date,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
