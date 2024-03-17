import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/points.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/widgets/barChart.dart';
import 'package:kumbh_sight/utils/widgets/lineChart.dart';

class personStat extends StatefulWidget {
  final List<point> lineData, barData;
  const personStat({super.key, required this.lineData, required this.barData});

  @override
  State<personStat> createState() => _personStatState();
}

class _personStatState extends State<personStat> {
  
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
                  'Line Chart to show frequency of queries with past hours',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
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
                  child: lineChartWidget(points: widget.lineData),
                ),
                const SizedBox(height: 8),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                const SizedBox(height: 8),
                const Text(
                    'Histogram to show average response time of resolver to queries'
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
                  child: BarChartWidget(points: widget.barData),
                ),
                const SizedBox(height: 8),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                const SizedBox(height: 8)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
