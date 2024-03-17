import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/points.dart';

class lineChartWidget extends StatelessWidget {
  final List<point> points;
  const lineChartWidget({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: points.map((ptr) => FlSpot(ptr.x, ptr.y)).toList(),
              isCurved: true,
              dotData: FlDotData(show: true)
            )
          ]
        )
      ),
    );
  }
}
