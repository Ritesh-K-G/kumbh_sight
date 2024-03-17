import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/points.dart';

class PieChartWidget extends StatelessWidget {
  final List<int> values;

  const PieChartWidget({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 5,
            borderData: FlBorderData(show: true),
            sectionsSpace: 2,
            sections: _buildPieChartSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    List<PieChartSectionData> sections = [];

    // Generate random colors
    final Random random = Random();
    for (int i = 0; i < values.length; i++) {
      final Color color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      sections.add(
        PieChartSectionData(
          value: values[i].toDouble(),
          color: color,
          radius: 100,
        ),
      );
    }
    return sections;
  }
}
