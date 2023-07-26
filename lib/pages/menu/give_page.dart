import 'package:church_app/pages/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class GivePage extends StatelessWidget {
  const GivePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Center(child: Text('Give')),
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
          width: size.width,
          height: size.height,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Text(
                'Tithely',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                  'Search for International Central Gospel Church, Liberty Temple',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text(
                'Paypal',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                  'Search for International Central Gospel Church, Liberty Temple',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text(
                'CashApp',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Search for \$ICGCNJLT',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(flex: 4),
            ],
          ),
        ),
        endDrawer: MenuDrawer(isAdmin: data.currentUser.isAdmin),
      ),
    );
  }
}
