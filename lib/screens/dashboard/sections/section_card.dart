import 'package:flutter/material.dart';
import 'package:prmt_admin/config/responsive.dart';
import '/constants/constants.dart';

import 'stats_chart.dart';

class SectionCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const SectionCard({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.all(defaultPadding * 0.75),
          //       height: 40,
          //       width: 40,
          //       decoration: BoxDecoration(
          //         color: Colors.yellow.withOpacity(0.1),
          //         borderRadius: const BorderRadius.all(Radius.circular(10)),
          //       ),
          //       child: SvgPicture.asset(
          //         'assets/icons/folder.svg',
          //         color: Colors.yellow,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Text(
          //       label,
          //       style: const TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.w600,
          //         letterSpacing: 1.2,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ],
          // ),
          //  const SizedBox(height: 40.0),
          StatsChart(
            value: value,
            color: color,
            showSmaller: Responsive.isMobile(context),
          ),
          //  const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
