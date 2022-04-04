import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:prmt_business/enums/enums.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '/utils/media_util.dart';
import '/models/failure.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/show_snackbar.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdMediaType extends StatelessWidget {
  const AdMediaType({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await MediaUtil.pickImageFromGallery(
      cropStyle: CropStyle.rectangle,
      context: context,
      imageQuality: 60,
      title: 'Crop and resize',
    );
    if (pickedImage != null) {
      context.read<CreateAdCubit>().imagePicked(pickedImage);
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    try {
      final pickedVideo = await MediaUtil.pickVideo(title: 'Select one video');

      if (pickedVideo != null) {
        final videoThumbnail = await VideoThumbnail.thumbnailData(
          video: pickedVideo.path,
          imageFormat: ImageFormat.PNG,
          maxWidth:
              128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 25,
        );
        context.read<CreateAdCubit>().videoPicked(pickedVideo, videoThumbnail);
      }
    } on Failure catch (failure) {
      ShowSnackBar.showSnackBar(context,
          title: failure.message, backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressContainer(progress: state.progress),
                  const SizedBox(height: 20.0),
                  Text(
                    'Ad Type',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Select your ad type to display how your\nad will look',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImagePreview(
                        width: _canvas.width * 0.41,
                        onTap: () async => _pickImage(context),
                        mediaType: state.mediaType,
                        mediFile: state.adMedia,
                        fit: BoxFit.cover,
                      ),
                      VideoPreview(
                        width: _canvas.width * 0.41,
                        onTap: () async => _pickVideo(context),
                        mediaType: state.mediaType,
                        videoThumbnail: state.videoThumbnail,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Notes:',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Image or videos should be square for best result.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Recommended Image size: 400px / 400px:',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Recommended Video size: 400px / 400px:',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  // const Spacer(),
                ],
              ),
            ),
            Positioned(
              right: 2.0,
              left: 2.0,
              bottom: 2.0,
              child: BottomNavButton(
                onTap: () {
                  if (state.adMedia != null) {
                    context
                        .read<CreateAdCubit>()
                        .changePage(AdCurrentPage.adContent);
                  } else {
                    ShowSnackBar.showSnackBar(context,
                        title: 'Please choose Ad image or video',
                        backgroundColor: Colors.deepOrange);
                  }
                },
                label: 'CONTINUE',
                isEnabled: true,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ImagePreview extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final BoxFit? fit;
  final MediaType? mediaType;
  final File? mediFile;

  const ImagePreview({
    Key? key,
    required this.width,
    required this.onTap,
    this.fit,
    this.mediaType,
    this.mediFile,
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
        child: mediFile != null && mediaType == MediaType.image
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(mediFile!, fit: fit),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.image,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Image Ad',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class VideoPreview extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final BoxFit? fit;
  final MediaType? mediaType;
  final Uint8List? videoThumbnail;

  const VideoPreview({
    Key? key,
    required this.width,
    required this.onTap,
    this.fit,
    this.mediaType,
    required this.videoThumbnail,
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
        child: videoThumbnail != null && mediaType == MediaType.video
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(videoThumbnail!, fit: fit),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.videocam,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Video Ad',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
