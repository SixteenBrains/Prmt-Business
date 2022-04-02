import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdVideoPlayer extends StatefulWidget {
  final File videoFile;
  const AdVideoPlayer({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<AdVideoPlayer> createState() => _AdVideoPlayerState();
}

class _AdVideoPlayerState extends State<AdVideoPlayer> {
  late VideoPlayerController _videoPlayercontroller;

  //TargetPlatform? _platform;
  ChewieController? _chewieController;
  bool _loading = false;

  Future<void> initializePlayer() async {
    _videoPlayercontroller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayercontroller,
      autoPlay: true,
      looping: true,
    );
    setState(() {
      _loading = true;
    });
  }

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _loading &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(
            controller: _chewieController!,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class AdVideoPlayer extends StatefulWidget {
//   final File videoFile;
//   const AdVideoPlayer({Key? key, required this.videoFile}) : super(key: key);

//   @override
//   State<AdVideoPlayer> createState() => _AdVideoPlayerState();
// }

// class _AdVideoPlayerState extends State<AdVideoPlayer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.videoFile)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _controller.value.isInitialized
//           ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             )
//           : Container(),
//     );
//   }
// }
