import 'package:church_app/pages/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Center(child: Text('Report Bug')),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Image.asset('assets/icons/menu.png',
                    color:
                        Theme.of(context).appBarTheme.actionsIconTheme!.color));
          })
        ],
      ),
      endDrawer: MenuDrawer(isAdmin: data.currentUser.isAdmin),
    ));
  }
}
