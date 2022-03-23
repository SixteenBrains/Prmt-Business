import 'package:flutter/material.dart';

class SocialStatus extends StatelessWidget {
  final int progress;

  const SocialStatus({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    print('Sizes --- ${(_canvas.width - 25) / 11} ');
    final _progressSize = (_canvas.width - 25) / 11;
    return Container(
      height: 10.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Container(
            width: _progressSize * progress,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          // CircleAvatar(
          //   radius: 30.0,
          //   backgroundColor: Colors.white,
          //   child: CircleAvatar(
          //     radius: 34.0,
          //     backgroundColor: Colors.red,
          //   ),
          // )
        ],
      ),
    );
  }
}
