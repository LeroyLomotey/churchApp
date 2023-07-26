import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';
import 'menu_drawer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Center(child: Text('Contact Us')),
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
        body: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.pin_drop),
                    const SizedBox(width: 10),
                    Text('438 Valley Street, Orange, NJ 07050',
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.call),
                    const SizedBox(width: 10),
                    Text('+1 (973) 674-7711 | (908) 906-2476',
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.mail),
                    const SizedBox(width: 10),
                    Text('Icgclibertytemplenj@gmail.com',
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
              ]),
        ),
        endDrawer: MenuDrawer(isAdmin: data.currentUser.isAdmin),
      ),
    );
  }
}
