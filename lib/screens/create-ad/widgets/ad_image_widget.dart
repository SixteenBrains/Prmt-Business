import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '/enums/enums.dart';

class MediaPreview extends StatefulWidget {
  final double width;
  final VoidCallback onTap;
  final Uint8List? imageFile;
  final IconData icon;
  final String label;
  final BoxFit? fit;
  final MediaType? mediaType;
  final File? mediFile;

  const MediaPreview({
    Key? key,
    required this.width,
    required this.onTap,
    this.imageFile,
    this.fit = BoxFit.cover,
    required this.icon,
    required this.label,
    required this.mediaType,
    required this.mediFile,
  }) : super(key: key);

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 120.0,
        width: widget.width,
        decoration: BoxDecoration(
          color: const Color(0xffF4F4F9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: widget.imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(widget.imageFile!, fit: widget.fit),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    widget.label,
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
