import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '/utils/image_util.dart';
import '/widgets/bottom_nav_button.dart';
import 'ad_content.dart';
import 'progress_container.dart';

class AdType extends StatelessWidget {
  const AdType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25.0),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffF4F4F9),
                    radius: 25.0,
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const ProgressContainer(progress: 2),
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
                  MediaType(
                    width: _canvas.width * 0.41,
                    onTap: () async {
                      final pickedImage = await ImageUtil.pickImageFromGallery(
                        cropStyle: CropStyle.rectangle,
                        context: context,
                        title: 'Select one image',
                      );

                      print('Picked image -- $pickedImage');
                    },
                    label: 'Image Ad',
                    icon: Icons.image,
                  ),
                  MediaType(
                    width: _canvas.width * 0.41,
                    onTap: () async {
                      final pickedVideo =
                          await ImageUtil.pickVideo(title: 'Select one video');

                      print('Picked video $pickedVideo');
                    },
                    label: 'Video Ad',
                    icon: Icons.videocam,
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
              SizedBox(height: _canvas.height * 0.27),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdContent(),
                  ),
                ),
                label: 'CONTINUE',
                isEnabled: false,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaType extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MediaType({
    Key? key,
    required this.width,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.0,
        width: width,
        // width: _canvas.width * 0.41,
        decoration: BoxDecoration(
          color: const Color(0xffF4F4F9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
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
