import 'package:church_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppData data = context.read<AppData>();
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      width: size.width * 0.5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: Column(
        children: [
          //Only show admin button is user has permission
          context.watch<AppData>().currentUser.isAdmin
              ? ListTile(
                  title: Text(
                    'Admin Panel',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/adminPage'),
                )
              : Container(),
          ListTile(
            title: Text(
              'Bug Report',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => Navigator.of(context).pushNamed('/reportPage'),
          ),
          ListTile(
            title: Text(
              'Contact Us',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => Navigator.of(context).pushNamed('/contactPage'),
          ),
          ListTile(
            title: Text(
              'About Us',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => Navigator.of(context).pushNamed('/aboutPage'),
          ),

          ListTile(
            title: Text(
              'Give',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => Navigator.of(context).pushNamed('/givePage'),
          ),
          ListTile(
            title: Text(
              'Dark Mode',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Switch(
                value: data.darkMode,
                onChanged: (value) => setState(() {
                      print('dark mode is $value');
                      data.darkMode = value;
                      print('dark mode but variable is ${data.darkMode}');
                    })),
          ),
          ListTile(
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              //remove all previous pages from the stack and go to login page
              onTap: () {
                Authentication().logout().then((value) => Navigator.of(context)
                    .pushNamedAndRemoveUntil('/loginPage', (route) => false));
              })
        ],
      ),
    );
  }
}
