import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return SizedBox(
      height: _canvas.height * 0.25,
      width: double.infinity,
      child: BetterPlayer.network(
        widget.videoUrl,
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          placeholderOnTop: false,
          controlsConfiguration:
              BetterPlayerControlsConfiguration(enableFullscreen: false),
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
