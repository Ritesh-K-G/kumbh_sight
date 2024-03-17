import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;

  const PieChartWidget({Key? key, required this.title, required this.data})
      : super(key: key);

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
    int index = 0;
    data.forEach((key, value) {
      final Color color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      sections.add(
        PieChartSectionData(
          value: value.toDouble(),
          color: color,
          title: key,
          radius: 100,
          titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
      index++;
    });
    return sections;
  }
}