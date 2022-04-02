import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '/enums/enums.dart';

import 'ad_video_thumnail.dart';

class MediaTypeWidget extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final MediaType mediaType;
  final Uint8List? imageFile;
  final File? videoFile;

  const MediaTypeWidget({
    Key? key,
    required this.width,
    required this.icon,
    required this.label,
    required this.onTap,
    this.imageFile,
    required this.mediaType,
    this.videoFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.0,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xffF4F4F9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: (imageFile != null && mediaType == MediaType.image)
            ? Image.memory(imageFile!)
            : (mediaType == MediaType.video && videoFile != null)
                ? SizedBox(
                    width: width,
                    child: AdVideoThumbnail(
                      videoFile: videoFile!,
                    ))
                // width: width, child: AdVideoPlayer(videoFile: videoFile!))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 50.0,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
