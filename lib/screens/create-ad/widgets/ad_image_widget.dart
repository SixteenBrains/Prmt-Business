import 'dart:typed_data';

import 'package:flutter/material.dart';

class MediaPreview extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final Uint8List? imageFile;
  final IconData icon;
  final String label;
  final BoxFit? fit;

  const MediaPreview({
    Key? key,
    required this.width,
    required this.onTap,
    this.imageFile,
    this.fit = BoxFit.cover,
    required this.icon,
    required this.label,
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
        child: imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(imageFile!, fit: fit),
              )
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
