import 'package:church_app/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class FlyerEditorPage extends StatefulWidget {
  const FlyerEditorPage({super.key});

  @override
  State<FlyerEditorPage> createState() => _FlyerEditorPageState();
}

class _FlyerEditorPageState extends State<FlyerEditorPage> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size size = MediaQuery.of(context).size;
    final flyerData = data.flyerData;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        color: Theme.of(context).primaryColor,
        child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: flyerData.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: () async {
                    await createAlert(
                      title: '',
                      content: 'Are you sure you want to delete this?',
                      noFunction: () {},
                      yesFunction: () =>
                          data.removeFlyer(flyerData[index], context),
                      context: context,
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.network(
                          color: const Color.fromARGB(158, 47, 109, 54),
                          colorBlendMode: BlendMode.lighten,
                          flyerData[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              AppData.defaultNetwork,
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      const Center(
                          child: Icon(color: Colors.white, Icons.delete))
                    ],
                  ));
            })),
      ),
    );
  }
}
