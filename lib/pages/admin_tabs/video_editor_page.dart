import 'package:flutter/material.dart';

class VideoEditorPage extends StatefulWidget {
  static final TextEditingController linkController = TextEditingController();
  const VideoEditorPage({super.key});

  @override
  State<VideoEditorPage> createState() => _VideoEditorPageState();

  static link() {
    return linkController.text;
  }
}

class _VideoEditorPageState extends State<VideoEditorPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Center(
              child: TextField(
                controller: VideoEditorPage.linkController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Paste a youtube video link',
                    hintStyle: TextStyle()),
              ),
            )
          ],
        ));
  }
}
