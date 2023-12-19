import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';
import '../../widgets/flyer_card.dart';

class FlyerPage extends StatelessWidget {
  const FlyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final data = Provider.of<AppData>(context);
    var flyers = data.flyerData.reversed.toList();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: flyers.length,
      itemBuilder: ((context, index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                imageCard(context, flyers[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Image.network(
                  color: const Color.fromARGB(158, 47, 109, 54),
                  colorBlendMode: BlendMode.lighten,
                  flyers[index],
                  width: screenSize.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      AppData.defaultNetwork,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Positioned(
                right: 30,
                top: 30,
                child: GestureDetector(
                  onTap: () async {
                    final path = await data.downloadImage(flyers[index]);
                    data.shareImage(path);
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.ios_share,
                        size: 30,
                        color: Colors.white,
                      )),
                )),
          ],
        );
      }),
    );
  }
}
