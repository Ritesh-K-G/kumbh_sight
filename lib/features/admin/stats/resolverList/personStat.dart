import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/points.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/widgets/barChart.dart';
import 'package:kumbh_sight/utils/widgets/lineChart.dart';
import 'package:kumbh_sight/utils/widgets/pieChart.dart';

class personStat extends StatefulWidget {
  const personStat({super.key});

  @override
  State<personStat> createState() => _personStatState();
}

class _personStatState extends State<personStat> {
  
  late List<point> pts = [point(x: 0, y: 0), point(x: 1, y: 1), point(x: 2, y: 2)];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics'
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Line Chart'
                ),
                Container(
                  width: AppHelpers.screenWidth(context) * 0.9,
                  height: AppHelpers.screenHeight(context) * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: lineChartWidget(points: pts),
                ),
                const SizedBox(height: 8),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                const SizedBox(height: 8),
                const Text(
                    'Histogram'
                ),
                Container(
                  width: AppHelpers.screenWidth(context) * 0.9,
                  height: AppHelpers.screenHeight(context) * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: BarChartWidget(points: pts),
                ),
                const SizedBox(height: 8),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                const SizedBox(height: 8),
                const Text(
                    'Pie Chart'
                ),
                Container(
                  width: AppHelpers.screenWidth(context) * 0.9,
                  height: AppHelpers.screenHeight(context) * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: PieChartWidget(values: [1, 2, 3, 4, 5, 6],),
                ),
                const SizedBox(height: 8),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
