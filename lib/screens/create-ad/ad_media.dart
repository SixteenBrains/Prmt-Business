import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '/utils/media_util.dart';
import '/models/failure.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/show_snackbar.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';
import 'widgets/ad_image_widget.dart';

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
      context
          .read<CreateAdCubit>()
          .imagePicked(await pickedImage.readAsBytes());
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    try {
      final pickedVideo = await MediaUtil.pickVideo(title: 'Select one video');

      if (pickedVideo != null) {
        final uint8list = await VideoThumbnail.thumbnailData(
          video: pickedVideo.path,
          imageFormat: ImageFormat.PNG,
          maxWidth:
              128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 25,
        );

        context.read<CreateAdCubit>().videoPicked(pickedVideo, uint8list);
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
        return SingleChildScrollView(
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
                  MediaPreview(
                    width: _canvas.width * 0.41,
                    onTap: () async => _pickImage(context),
                    // () async =>
                    //     state.adImage == null ? _pickImage(context) : null,
                    imageFile: state.adImage,
                    icon: Icons.image,
                    label: 'Image Ad',
                  ),
                  MediaPreview(
                    width: _canvas.width * 0.41,
                    onTap: () async => _pickVideo(context),
                    imageFile: state.adVideoThumbnail,
                    icon: Icons.videocam,
                    label: 'Video Ad',
                    fit: BoxFit.contain,
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
              SizedBox(height: _canvas.height * 0.27),
              BottomNavButton(
                onTap: () {
                  if (state.adImage != null || state.adVideo != null) {
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
            ],
          ),
        );
      },
    );
  }
}
