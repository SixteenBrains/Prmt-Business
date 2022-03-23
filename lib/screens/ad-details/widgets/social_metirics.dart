import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SocialMetirics extends StatelessWidget {
  final String label;
  final int percent;
  final Color color;

  const SocialMetirics({
    Key? key,
    required this.label,
    required this.percent,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            // vertical: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        // SliderTheme(
        //   data: const SliderThemeData(
        //     trackHeight: 8.0,
        //     thumbColor: Colors.green,
        //     overlayColor: Colors.white,
        //     overlappingShapeStrokeColor: Colors.white,
        //     thumbShape:
        //         RoundSliderThumbShape(enabledThumbRadius: 12.0),
        //     overlayShape:
        //         RoundSliderOverlayShape(overlayRadius: 10.0),
        //   ),
        //   child: Slider(
        //     activeColor: const Color(0xff1FCFB8),
        //     thumbColor: const Color(0xff1FCFB8),
        //     value: 0.6,
        //     onChanged: (val) {},
        //   ),
        // ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xff1FCFB8),
            inactiveTrackColor: Colors.grey,
            // trackShape: const RectangularSliderTrackShape(),
            // trackHeight: 5.0,
            // thumbColor: Colors.blueAccent,
            // thumbShape: const RoundSliderThumbShape(
            //     enabledThumbRadius: 12.0),
            // overlayColor: Colors.red.withAlpha(32),
            // overlayShape: const RoundSliderOverlayShape(
            //     overlayRadius: 28.0),
          ),
          child: SfSlider(
            activeColor: color,
            inactiveColor: const Color(0xffDDDDDD),
            // trackShape: const SfTrackShape(),
            thumbIcon: CircleAvatar(
              radius: 8.0,
              backgroundColor: color,
              child: const CircleAvatar(
                radius: 3.0,
                backgroundColor: Colors.white,
              ),
            ),
            value: 0.6,
            onChanged: (v) {},
          ),
        ),
      ],
    );
  }
}
