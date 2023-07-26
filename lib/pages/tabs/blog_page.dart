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
    Size screenSize = MediaQuery.of(context).size;
    List<Blog> blogData = Provider.of<AppData>(context).blogData;
    return ListView.builder(
        padding:
            const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 80),
        itemCount: blogData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => {
              Navigator.of(context).pushNamed('/blogViewerPage',
                  arguments: {'blog': blogData[index]})
            },
            child: Container(
              width: screenSize.width,
              height: 100,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: blogData[index].image.substring(0, 6) == 'assets'
                        ? Image.asset(
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            blogData[index].image)
                        : Image.network(
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            blogData[index].image),
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
                                style: Theme.of(context).textTheme.titleMedium),
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

          /*GestureDetector(
            onTap: () => {
                        Navigator.of(context).pushNamed('/blogViewerPage',
                            arguments: {'blog': blogData[index]})
                      },

            child: 
              Row(
                  children: [
                    Card(
                      child: Container(
                    width: screenSize.width,
                    height: 300,
                    padding: const EdgeInsets.all(15),
                    // color: ThemeClass.tertiaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(children: [
                            Image.asset(
                                width: double.maxFinite,
                                height: 170,
                                fit: BoxFit.cover,
                                blogData[index].image),
                            //----------expand icon
                            Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.open_in_full,
                                      size: 30,
                                      color: Colors.white,
                                    )))
                          ]),
                        ),
                        const Spacer(),
                        //Title
                        Text(
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            blogData[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const Spacer(),
                        Text(
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            blogData[index].body,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 220, 219, 219))),
                        const Spacer(),
                        Text(
                            maxLines: 1,
                            AppData.formatDate(blogData[index].date),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 220, 219, 219)))
                      ,
                    ),
                  
                  ),),
              const SizedBox(
                height: 30,
              )
            ],
          ),);
          */
        });
  }
}
