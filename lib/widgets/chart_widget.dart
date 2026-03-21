
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(spots: [
          FlSpot(0, 1),
          FlSpot(1, 3),
          FlSpot(2, 2),
        ])
      ]
    ));
  }
}
