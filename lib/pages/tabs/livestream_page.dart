import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../services/app_data.dart';
import '../../services/themes.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String link = Provider.of<AppData>(context).streamLink;

    final videoId =
        Uri.parse(link).pathSegments.last; //?? AppData.defaultVideo;
    print('Vid ID ${Uri.parse(link).pathSegments.last}');
    //print('No match? ${match.toString()}');
    setState(() {
      // Load the new video
      _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            isLive: true,
            autoPlay: false,
          ));
    });
    return SafeArea(
      child: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: ThemeClass.primaryColor,
            handleColor: ThemeClass.primaryColor,
          ),
        ),
      ),
    );
  }
}
