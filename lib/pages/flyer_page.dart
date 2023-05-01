import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../app_data.dart';

class FlyerPage extends StatelessWidget {
  const FlyerPage({super.key});

  sharePoster(String flyer) async {
    ByteData imagebyte = await rootBundle.load(flyer);
    Share.shareXFiles(
      [
        XFile.fromData(
          imagebyte.buffer.asUint8List(),
          mimeType: 'image/webp',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    var flyers = Provider.of<AppData>(context).flyerData;
    return ListView.builder(
      itemCount: flyers.length,
      itemBuilder: ((context, index) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Image.asset(
                flyers[index],
                width: screenSize.width,
              ),
            ),
            Positioned(
                right: 30,
                top: 30,
                child: GestureDetector(
                  onTap: () async => {sharePoster(flyers[index])},
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
