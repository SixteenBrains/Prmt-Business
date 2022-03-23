import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/models/chart_data.dart';

class ShowPieChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String label;
  final int count;

  const ShowPieChart({
    Key? key,
    required this.chartData,
    required this.count,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 38,
          sections:
              showingSections(chartData: chartData, count: count, label: label),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required List<ChartData> chartData,
    required int count,
    required String label,
  }) {
    return List.generate(chartData.length, (i) {
      const radius = 7.0;
      return PieChartSectionData(
        color: chartData[i].color,
        value: chartData[i].count,
        //   title: '40%',
        showTitle: false,
        badgeWidget: i == 0
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$count',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: label,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        badgePositionPercentageOffset: -5,
        radius: radius,
        titleStyle: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
      );
    });
  }
}
