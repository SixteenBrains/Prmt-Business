import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;

  const CustomChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F9),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // child: Chip(
      //     // padding: const EdgeInsets.symmetric(
      //     //     horizontal: 10.0, vertical: 10.0),
      //     backgroundColor: const Color(0xffF4F4F9),
      //     label: Text(interest)),
    );
  }
}
