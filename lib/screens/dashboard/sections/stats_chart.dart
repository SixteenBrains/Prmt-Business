import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/constants/constants.dart';

class StatsChart extends StatelessWidget {
  final int value;
  final bool showSmaller;
  final Color color;
  const StatsChart({
    Key? key,
    required this.value,
    this.showSmaller = false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: showSmaller ? 40.0 : 50.0,
              startDegreeOffset: showSmaller ? -20.0 : -20.0,
              //sections: statsData,
              sections: [
                PieChartSectionData(
                  // color: primaryColor,
                  color: color,
                  value: value.toDouble(),
                  showTitle: false,
                  radius: showSmaller ? 5 : 7,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),

                ///const Text('of 128GB')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> statsData = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 10,
  ),

  // PieChartSectionData(
  //   color: secondaryColor,
  //   value: 50,
  //   showTitle: false,
  //   radius: 10,
  // ),
  // PieChartSectionData(
  //   color: const Color(0xFF26E5FF),
  //   value: 20,
  //   showTitle: false,
  //   radius: 22,
  // ),
  // PieChartSectionData(
  //   color: const Color(0xFFFFCF26),
  //   value: 10,
  //   showTitle: false,
  //   radius: 19,
  // ),
  // PieChartSectionData(
  //   color: const Color(0xFFEE2727),
  //   value: 15,
  //   showTitle: false,
  //   radius: 16,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 13,
  // ),
];
