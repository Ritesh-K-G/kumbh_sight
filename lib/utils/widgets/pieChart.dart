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
        padding: const EdgeInsets.all(0.0),
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 10,
            borderData: FlBorderData(show: true),
            sectionsSpace: 4,
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
      int bias=random.nextInt(3);
      final Color color = Color.fromRGBO(
        random.nextInt(256)+(bias==0?150:0),
        random.nextInt(256)+(bias==1?150:0),
        random.nextInt(256)+(bias==2?150:0),
        1,
      );

      sections.add(
        PieChartSectionData(
          value: value.toDouble(),
          color: color,
          title: key,
          radius: 115,
          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
      index++;
    });
    return sections;
  }
}