import 'package:flutter/material.dart';
import 'package:prmt_admin/constants/constants.dart';
import '/enums/enums.dart';
import 'custom_video_player.dart';
// import '/widgets/display_image.dart';
// import 'custom_video_player.dart';

class ShowMedia extends StatelessWidget {
  final String? mediaUrl;
  final MediaType mediaType;
  final double? height;
  final BoxFit fit;
  const ShowMedia({
    Key? key,
    required this.mediaUrl,
    required this.mediaType,
    this.fit = BoxFit.contain,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return mediaType == MediaType.image
        ? Image.network(
            mediaUrl ?? errorImage,
            height: height ?? _canvas.height * 0.25,
            width: double.infinity,
            fit: fit,
          )
        : mediaUrl != null
            ? CustomVideoPlayer(
                videoUrl: mediaUrl!,
                height: height,
              )
            : SizedBox(
                height: height ?? _canvas.height * 0.25,
                width: double.infinity,
                child: const Icon(
                  Icons.error,
                  color: Colors.grey,
                ),
              );
    //CustomVideoPlayer(videoUrl: mediaUrl!)

    // : Container(
    //     decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(4.0),
    //         topRight: Radius.circular(4.0),
    //       ),
    //     ),
    //     height: height ?? _canvas.height * 0.25,
    //     width: double.infinity,
    //     child: const Center(
    //       child: Icon(
    //         Icons.error,
    //         color: Colors.grey,
    //       ),
    //     ),
    //   );
  }
}
