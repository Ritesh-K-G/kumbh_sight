import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/points.dart';

class BarChartWidget extends StatelessWidget {
  final List<point> points;

  const BarChartWidget({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    points.sort((a, b) => a.x.compareTo(b.x));
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
                border: const Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide(width: 1),
                    bottom: BorderSide(width: 1))),
            groupsSpace: 10,
            barGroups: _buildBarGroups(),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return points.map((ptr) {
      return BarChartGroupData(
          x: ptr.x.toInt(),
          barRods: [
            BarChartRodData(
                toY: ptr.y,
                width: 15,
                color: Colors.pink,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ))
          ]);
    }).toList();
  }
}
