import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/blog.dart';
import '../../services/app_data.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppData data = context.watch<AppData>();
    List<Blog> blogData = data.blogData.reversed.toList();
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          padding:
              const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 80),
          itemCount: blogData.length,
          itemBuilder: (context, index) {
            var image = blogData[index].image;
            if (image.length < 5 || image == 'null') {
              image = 'assets/images/logo.png';
            }
            context.watch<AppData>().darkMode;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => {
                Navigator.of(context).pushNamed('/blogViewerPage',
                    arguments: {'blog': blogData[index]})
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
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                          image.substring(0, 6) == 'assets'
                              ? Image.asset(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  color: const Color.fromARGB(158, 47, 109, 54),
                                  colorBlendMode: BlendMode.lighten,
                                  image)
                              : Image.network(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  color: const Color.fromARGB(158, 47, 109, 54),
                                  colorBlendMode: BlendMode.lighten,
                                  image),
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
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
